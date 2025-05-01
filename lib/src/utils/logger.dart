import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;
import 'package:stack_trace/stack_trace.dart' as stacktrace;
import 'date.dart';

final isUnitTest = Platform.environment.containsKey('FLUTTER_TEST');

Future<Uri> _currentDartFilePath({int depth = 4}) async {
  final caller = stacktrace.Frame.caller(depth);
  final uri = caller.package != null
      ? (isUnitTest ? _packageConfig.resolve(caller.uri)! : Platform.script)
      : caller.uri;
  return uri;
}

Future<Uri> currentDartFilePath({int depth = 2}) =>
    _currentDartFilePath(depth: depth);

Future<Uri> logFileFoleder() async {
  final filePath = await _currentDartFilePath();
  try {
    return isUnitTest
        ? Uri.directory(path.dirname(filePath.toFilePath()))
        : _packageConfig.packageOf(filePath)!.root;
  } catch (e) {
    final file = File(filePath.toFilePath());
    if (file.parent.existsSync()) {
      return file.parent.uri;
    }
    if (kDebugMode) {
      print('$file not exists');
    }
    rethrow;
  }
}

Future<File> currentTestLogFile() async => File(
      path.join(
        (await logFileFoleder()).toFilePath(),
        '${DateTime.now().toLocal().toDateString().replaceAll(':', '')}.log',
      ),
    );

Future<Logger> getLogger({Level level = Level.debug}) async => Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        noBoxingByDefault: true,
      ),
      // level: level,
      output: MultiOutput([
        FileOutput(
          file: await currentTestLogFile(),
        ),
        ConsoleOutput(),
      ]),
    );

bool _inited = false;
late final Logger _logger;
late final PackageConfig _packageConfig;

Future<Logger> loggerInit({Level level = Level.debug}) async {
  if (_inited) {
    return _logger;
  }
  final sourceRoot = Platform.environment['PH_CHART_SOURCE_ROOT'];
  final packageConfig = await findPackageConfigUri(Platform.script) ??
      (sourceRoot != null
          ? await findPackageConfigUri(Uri.file(sourceRoot, windows: true))
          : null);
  if (packageConfig != null) {
    _packageConfig = packageConfig;
  } else {
    throw Exception('can not find packageConfig for \n'
        '\tPlatform.script: ${Platform.script}\n'
        '\tEnvironment variable PH_CHART_SOURCE_ROOT: $sourceRoot');
  }
  _logger = await getLogger();

  _inited = true;
  return _logger;
}

Logger get logger {
  assert(_inited, 'run loggerInit() before using this');
  return _logger;
}
