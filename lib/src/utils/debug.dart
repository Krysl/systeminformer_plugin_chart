// ignore_for_file: unnecessary_raw_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import '../messages.dart';
import '../settings.dart';
import 'logger.dart';

Future<Uri?> setVmServiceUri() async {
  if (kDebugMode) {
    return Service.getInfo().then((info) {
      final url = info.serverUri;
      if (url != null) {
        saveVmServiceInfoFile(url);
        patchLaunchJson(url);
        return url;
      }
      return null;
    });
  }
  return null;
}

Future<void> saveVmServiceInfoFile(Uri url) async {
  final dartVmServiceInfo = {
    'baseUrl': url.toString(),
    'apiKey': 'your_api_key',
    'timeout': 3000,
  };
  const encoder = JsonEncoder.withIndent('  ');
  await File('dart-vm-service-url.json')
      .writeAsString(encoder.convert(dartVmServiceInfo));
}

const urlRegex = r'http://127.0.0.1:\d+/[-A-Za-z0-9+_]*=/';
final vmServiceUriRegex = RegExp(
  // r'^(?<left>\s*"vmServiceUri":\s*")(?<url>http://127.0.0.1:\d+/[0-9a-zA-Z]+=/)(?<right>"\s*,?\s*(//.*)?)$',
  r'^(?<left>\s*"vmServiceUri":\s*")(?<url>' +
      urlRegex +
      r')(?<right>"\s*,?\s*(//.*)?)$',
);

Future<void> patchLaunchJson(Uri url) async {
  final SystemInformerHostApi hostApi = SystemInformerHostApi();
  final path = await hostApi.getStringSetting(
    SETTING_NAME_VSCODE_LAUNCH_JSON,
  ); // TODO(krysl): alternative: using env variable
  final file = File(path);
  if (file.existsSync()) {
    if (kDebugMode) {
      logger.i('patcheing $path');
    }
    bool patched = false;
    final lines = await file.readAsLines();
    final strBuf = StringBuffer();
    for (final line in lines) {
      final match = vmServiceUriRegex.firstMatch(line);
      if (match != null) {
        final left = match.namedGroup('left') ?? '';
        final right = match.namedGroup('right') ?? '';
        final patchedLine = '$left$url$right';
        strBuf.writeln(patchedLine);
        patched = true;
        if (kDebugMode) {
          logger.i('patched: $patchedLine');
        }
      } else {
        strBuf.writeln(line);
        if (kDebugMode) {
          logger.i('reserve: $line');
        }
      }
    }
    if (kDebugMode) {
      logger.i('==== has ${patched ? '' : 'NOTHING '}patched ==== $url');
    }
    if (patched) {
      await file.writeAsString(strBuf.toString());
    }
  }
}
