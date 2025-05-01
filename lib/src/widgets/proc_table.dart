import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../system_informer/data_type.dart';
import '../system_informer/generated_bindings.dart';

class SimpleProcessTable extends StatelessWidget {
  const SimpleProcessTable({required this.items, super.key});

  final List<PPH_PROCESS_ITEM> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FixedColumnWidth(64),
          4: FixedColumnWidth(64),
          5: FixedColumnWidth(160),
          6: FixedColumnWidth(64),
          7: FixedColumnWidth(64),
        },
        children:
            items
                .map((item) => item.ref)
                .map(
                  (item) => TableRow(
                    children:
                        [
                          '${item.ProcessName.toDartString()}',
                          '${item.FileName.toDartString() ?? item.FileName.toDartString()}',
                          '${item.CommandLine.toDartString()}',
                          '${item.VerifySignerName.toDartString()}',
                          '${item.PackageFullName.toDartString()}',
                          '${item.UserName.toDartString()}',
                          '${item.ProcessId.address}',
                          '${item.WorkingSetPrivateSize}',
                        ].map((text) => TableCell(child: Text(text))).toList(),
                  ),
                )
                .toList(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<PPH_PROCESS_ITEM>('items', items));
  }
}
