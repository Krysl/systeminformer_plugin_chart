import 'dart:io';

import 'package:csv/csv.dart';

import '../utils/logger.dart';

const csvToListConverter = CsvToListConverter();

base class SystemInformerData {}

const testCsvPath = 'test/data/csv/System Informer Processes.csv';

final class SystemInformerDataCSV extends SystemInformerData {
  final String version;
  final String system;
  final String dateTime;
  final List<String> headers;
  final List<List<dynamic>> data;
  SystemInformerDataCSV({
    required this.version,
    required this.system,
    required this.dateTime,
    required this.headers,
    required this.data,
  });

  factory SystemInformerDataCSV.fromCsvFilePath(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      logger.e('current path = ${Directory.current.path}');
      throw PathNotFoundException(path, const OSError());
    }
    final lines = file.readAsLinesSync();

    final csv = csvToListConverter
        .convert(lines.getRange(4, lines.length).join('\r\n'));
    final ppids = <int>[-1];
    final headers = csvToListConverter.convert(lines[4]).first.cast<String>();
    final nameIndex = headers.indexOf('Name');
    final pidIndex = headers.indexOf('PID');
    if (nameIndex > -1 && pidIndex > -1) {
      headers
        ..add('ParentProcessId')
        ..add('Depth');
      int prePid = 0;
      int preLevel = 0;
      for (final line in csv.skip(1)) {
        final rawName = line[nameIndex] as String;
        final pid = int.tryParse(line[pidIndex] as String) ?? 0;
        final rawLen = rawName.length;

        final name = rawName.trimLeft();
        line[nameIndex] = name;
        final level = (rawLen - name.length) ~/ 2;
        final levelChange = level - preLevel;
        if (levelChange > 0) {
          ppids.add(prePid);
        } else if (levelChange < 0) {
          var i = -levelChange;
          while (i-- > 0) {
            ppids.removeLast();
          }
        }
        preLevel = level;
        line
          ..add(ppids.last)
          ..add(level);
        prePid = pid;
      }
    }
    return SystemInformerDataCSV(
      version: lines[0],
      system: lines[1],
      dateTime: lines[2],
      headers: headers,
      data: csv.sublist(1),
    );
  }
  // operator [](String header)
}
