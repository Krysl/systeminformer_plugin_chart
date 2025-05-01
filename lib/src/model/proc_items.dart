import 'dart:ffi';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import '../messages.g.dart';
import '../system_informer/data_type.dart';
import '../system_informer/generated_bindings.dart';
import 'csv.dart';

extension ToProcessItems on ProcessItemsRaw {
  ProcessItems toProcessItem() => ProcessItems.fromRaw(this);
}

extension type Pid(int pid) {
  // Wraps the 'int' type's '<' operator:
  bool operator <(Pid other) => pid < other.pid;
  // Doesn't declare the '+' operator, for example,
  // because addition does not make sense for ID numbers.
  factory Pid.parse(String source) => int.parse(source).toPid();
  String get id => pid.toString();
}

class PidConverter implements JsonConverter<Pid, int> {
  const PidConverter();

  @override
  Pid fromJson(int json) => json.toPid();

  @override
  int toJson(Pid object) => object.pid;
}

extension ToPid on int {
  Pid toPid() => Pid(this);
}

final bytesStringExp = RegExp(
  r'(?<num>\d+(\.\d+)?) ?(?<metricPrefix>k|M|G|T)?B?$',
);
const k = 1024;
const M = k * 1024;
const G = M * 1024;
const T = G * 1024;

int rawBytesParse(String input) {
  final match = bytesStringExp.firstMatch(input);
  assert(match != null, '');
  final number = double.parse(match!.namedGroup('num')!);
  final metricPrefix = switch (match.namedGroup('metricPrefix') ?? '') {
    '' => 1,
    'k' => k,
    'M' => M,
    'G' => G,
    'T' => T,
    String() => throw UnimplementedError(),
  };
  return (number * metricPrefix).toInt();
}

int bytesParse(String input) {
  final bytes = rawBytesParse(input);
  assert(
    () {
      final str2 = bytesToString(bytes);
      final bytes2 = rawBytesParse(str2);
      // logger.i('$input ${str2}');
      return bytes == 0 || ((bytes2 - bytes) / bytes) < 0.1;
    }(),
    'bytesParse test failed', //
  );

  return bytes;
}

String bytesToString(int bytes) {
  final metric = log(bytes) / log(1024);
  return switch (metric) {
    < 1 => bytes.toString(),
    < 2 => '${(bytes / k).toStringAsFixed(3)} kB',
    < 3 => '${(bytes / M).toStringAsFixed(3)} MB',
    < 4 => '${(bytes / G).toStringAsFixed(3)} GB',
    >= 4 => '${(bytes / T).toStringAsFixed(3)} TB',
    double() => throw UnimplementedError(),
  };
}

class ImageListItem {
  PPH_STRING fileName;
  int largeIconIndex;
  int smallIconIndex;
  ImageListItem({
    required this.fileName,
    required this.largeIconIndex,
    required this.smallIconIndex,
  });

  factory ImageListItem.fromPointer(PPH_IMAGELIST_ITEM ptr) {
    return ImageListItem(
      fileName: ptr.ref.FileName,
      largeIconIndex: ptr.ref.LargeIconIndex,
      smallIconIndex: ptr.ref.SmallIconIndex,
    );
  }
}

sealed class ProcessItem {
  const ProcessItem();
  String? get name;
  int get pid;
  double get cpu;
  int get privateBytes;

  String? get fileName;
  String? get commandLine;
  int get workingSet;
  int get privateWorkingSet;

  int get parentProcessId;

  ImageListItem? get iconEntry;
}

class ProcessItemConst extends ProcessItem {
  const ProcessItemConst({
    required this.name,
    required this.pid,
    this.cpu = 0,
    this.privateBytes = 0,
    this.privateWorkingSet = 0,
    this.workingSet = 0,
    this.commandLine = '',
    this.fileName = '',
    this.parentProcessId = 0,
    this.iconEntry,
  });
  ProcessItemConst.from(ProcessItem item)
    : name = item.name ?? '',
      pid = item.pid,
      cpu = item.cpu,
      privateBytes = item.privateBytes,
      privateWorkingSet = item.privateWorkingSet,
      workingSet = item.workingSet,
      commandLine = item.commandLine,
      fileName = item.fileName,
      parentProcessId = item.parentProcessId,
      iconEntry = item.iconEntry;

  @override
  final String? commandLine;

  @override
  final double cpu;

  @override
  final String? fileName;

  @override
  final String name;

  @override
  final int parentProcessId;

  @override
  final int pid;

  @override
  final int privateBytes;

  @override
  final int privateWorkingSet;

  @override
  final int workingSet;

  @override
  final ImageListItem? iconEntry;
}

enum ProcessItemType { ph, csv }

class ProcessItemPH extends ProcessItem {
  final PPH_PROCESS_ITEM raw;

  ProcessItemPH({required this.raw});

  PH_PROCESS_ITEM get ref => raw.ref;

  @override
  String? get name => ref.ProcessName.toDartString();
  @override
  int get pid {
    final thisName = name;
    if (thisName != null && invalidPidNames.containsKey(thisName)) {
      return invalidPidNames[thisName]!;
    }
    return ref.ProcessId.address;
  }

  @override
  double get cpu => ref.CpuUsage;
  @override
  int get privateBytes => ref.VmCounters.PagefileUsage;

  @override
  String? get fileName => ref.FileName.toDartString();
  @override
  String? get commandLine => ref.CommandLine.toDartString();

  @override
  int get workingSet => ref.VmCounters.WorkingSetSize;

  @override
  int get privateWorkingSet => ref.WorkingSetPrivateSize;

  @override
  int get parentProcessId => ref.ParentProcessId.address;

  @override
  ImageListItem? get iconEntry =>
      ref.IconEntry.address == 0
          ? null
          : ImageListItem.fromPointer(ref.IconEntry);
}

enum InvalidPid {
  root('Root'),
  systemIdleProcess('System Idle Process'),
  interrupts('Interrupts');

  const InvalidPid(this.name);
  // final int pid;
  final String name;

  Pid get pid => (-index).toPid();

  int get total => InvalidPid.values.length;
}

final invalidPidNames = InvalidPid.values.asMap().map(
  (_, value) => MapEntry(value.name, value.pid.pid),
);

class ProcessItemCSV extends ProcessItem {
  final List<String> headers;
  final List<dynamic> data;

  ProcessItemCSV({required this.headers, required this.data});

  dynamic operator [](String name) {
    final index = headers.indexOf(name);
    if (index == -1) {
      return null;
    }
    return data[index];
  }

  void operator []=(String name, dynamic value) {
    final index = headers.indexOf(name);
    if (index == -1) {
      return;
    }
    data[index] = value;
  }

  @override
  String? get name => this['Name'] as String?;
  @override
  int get pid {
    final thisName = name;
    if (thisName != null && invalidPidNames.containsKey(thisName)) {
      return invalidPidNames[thisName]!;
    }
    return _parse('PID');
  }

  @override
  double get cpu => _parse('CPU');
  @override
  int get privateBytes {
    final privateBytes = this['Private bytes'] as String;
    return bytesParse(privateBytes);
  }

  @override
  String? get fileName => (this['File name'] ?? this['Name']) as String?;
  @override
  String? get commandLine => this['Command line'] as String?;
  @override
  int get workingSet => _parse('Working set');
  @override
  int get privateWorkingSet => _parse('Private WS');

  @override
  int get parentProcessId => this['ParentProcessId'] as int;

  @override
  ImageListItem? get iconEntry => null;

  int _parseInt(dynamic input) {
    if (input is num) {
      return input as int;
    } else if (input is String) {
      if (input.isEmpty) {
        return 0;
      }
      return rawBytesParse(input);
    }
    return 0;
  }

  T _parse<T>(String name) {
    final data = this[name];
    return switch (T) {
      // ignore: type_literal_in_constant_pattern
      int => _parseInt(data) as T,
      // ignore: type_literal_in_constant_pattern
      double =>
        switch (data.runtimeType) {
              // ignore: type_literal_in_constant_pattern
              String => (data as String).isEmpty ? -0.0 : double.parse(data),
              _ => throw UnimplementedError(),
            }
            as T,
      _ =>
        throw UnimplementedError(
          'ProcessItemCSV can not parse ${data.runtimeType}',
        ),
    };
  }

  ProcessItemCSV deepCopy() {
    return ProcessItemCSV(headers: List.from(headers), data: List.from(data));
  }
}

enum DataPicker {
  cpu('CPU', pick: _pickCpuUsage, toDisplayText: displayCPU),
  privateBytes(
    'Private bytes',
    pick: _pickPrivateBytes,
    toDisplayText: displayBytes,
  ),
  workingSet('Working set', pick: _pickWorkingSet, toDisplayText: displayBytes),
  privateWorkingSet(
    'Private WS',
    pick: _pickPrivateWorkingSet,
    toDisplayText: displayBytes,
  )
  //
  ;

  const DataPicker(
    this.name, {
    required this.pick,
    required this.toDisplayText,
  });

  final String name;
  final num Function(ProcessItem item) pick;
  final String Function(num n) toDisplayText;

  static num _pickCpuUsage(ProcessItem item) => item.cpu;
  static num _pickPrivateBytes(ProcessItem item) => item.privateBytes;
  static num _pickWorkingSet(ProcessItem item) => item.workingSet;
  static num _pickPrivateWorkingSet(ProcessItem item) => item.privateWorkingSet;

  static String displayCPU(num n) => '${(n * 100).toStringAsFixed(2)}%';
  static String displayBytes(num bytes) => bytesToString(bytes.toInt());
}

enum ProcessDatas { cpu, privateBytes }

class ProcessItems<Item extends ProcessItem> {
  final Map<Pid, Item> _items;
  final String? briefInfo;

  const ProcessItems({required Map<Pid, Item> items, this.briefInfo})
    : _items = items;

  static ProcessItems<ProcessItem> fromRaw(ProcessItemsRaw raw) {
    final Map<Pid, ProcessItem> items = raw.items
        .map(Pointer<PH_PROCESS_ITEM>.fromAddress)
        .toList()
        .asMap()
        .map((key, value) {
          final processItemPH = ProcessItemPH(raw: value);
          return MapEntry(
            processItemPH.pid.toPid(),
            ProcessItemConst.from(processItemPH),
          );
        });
    return ProcessItems<ProcessItem>(items: items);
  }

  static ProcessItems<ProcessItemCSV> fromCSV(SystemInformerDataCSV csv) {
    final dataMap = csv.data.asMap();

    final Map<Pid, ProcessItemCSV> items = dataMap.map((key, value) {
      final item = ProcessItemCSV(headers: csv.headers, data: value);
      final processId = item.pid;

      return MapEntry(processId.toPid(), item);
    });
    return ProcessItems<ProcessItemCSV>(
      items: items,
      briefInfo: [csv.version, csv.system, csv.dateTime].join(' ' * 10),
    );
  }

  static ProcessItems<ProcessItemCSV> fromCsvFilePath(String path) {
    final csv = SystemInformerDataCSV.fromCsvFilePath(path);
    return ProcessItems.fromCSV(csv);
  }

  int get length => _items.length;
  void clear() {
    _items.clear();
    // TODO(krysl): free memory
  }

  bool existsPid(Pid pid) => _items.containsKey(pid);
  ProcessItem? getItemByPid(Pid pid) => _items[pid];
  ProcessItem? getItemByIndex(int index) {
    assert(
      index < _items.length,
      'index($index) out of bounds(${_items.length})',
    );

    return _items.values.elementAt(index);
  }

  List<Pid> getInheritanceTree(ProcessItem item) {
    final List<Pid> ids = [item.pid.toPid()];
    if (item is ProcessItemPH || item is ProcessItemCSV) {
      var i = item;
      while (true) {
        final parentId = i.parentProcessId.toPid();
        final parent = _items[parentId];
        if (parent != null && (ids.isEmpty || ids.last != parentId)) {
          ids.add(parentId);
          i = parent;
        } else {
          break;
        }
      }
    }

    return ids;
  }

  Iterable<MapEntry<Pid, Item>> get entires => _items.entries;
}
