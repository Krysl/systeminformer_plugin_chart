import 'package:flutter_test/flutter_test.dart';
import 'package:systeminformer_plugin_chart/src/model/csv.dart';

void main() {
  group('SystemInformerData', () {
    test('', () async {
      final csv = SystemInformerDataCSV.fromCsvFilePath(
        'test/data/csv/System Informer Processes.csv',
      );
      print(csv.data);
    });
  });
}
