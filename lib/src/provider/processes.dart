import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../messages.g.dart';
import '../model/proc_items.dart';
import '../model/statistics.dart';
import '../system_informer/generated_bindings.dart';

part 'processes.freezed.dart';
part 'processes.g.dart';

@freezed
abstract class ProcesssInfo with _$ProcesssInfo {
  factory ProcesssInfo({
    ProcessItems? processItems,
    ProcessItemType? itemsType,
    @protected Pointer<PH_PLUGIN_SYSTEM_STATISTICS>? ptrStatistics,
    PluginSystemStatisticsInformation? statistics,
    Pointer<PH_SYSTEM_BASIC_INFORMATION>? ptrSystemBasicInformation,
    @Default(true) bool sortBySize,
    @Default(DataPicker.privateBytes) DataPicker dataSetSelect,
    @Default(false) bool hideIdle,
    String? briefInfo, 
  }) = _ProcesssInfo;
}

@riverpod
class Processes extends _$Processes {
  final SystemInformerHostApi _hostApi = SystemInformerHostApi();

  @override
  ProcesssInfo build() {
    return ProcesssInfo();
  }

  ProcessItems? get processItems => state.processItems;

  void updateCsvProcesses(String csvPath) {
    final items = ProcessItems.fromCsvFilePath(csvPath);

    state = state.copyWith(
      processItems: items,
      itemsType: ProcessItemType.csv,
      briefInfo: items.briefInfo,
      ptrStatistics: null,
      statistics: null,
    );
  }

  Future<ProcessItems<ProcessItem>> _takeCurrentProcesses() async =>
      _hostApi.enumProcessItems().then((r) => r.toProcessItem());

  Future<void> updateCurrentProcesses() async {
    state = state.copyWith(
      processItems: await _takeCurrentProcesses(),
      itemsType: ProcessItemType.ph,
    );
  }

  Future<Pointer<PH_PLUGIN_SYSTEM_STATISTICS>> _takeSystemStatistics() async =>
      Pointer<PH_PLUGIN_SYSTEM_STATISTICS>.fromAddress(
        await _hostApi.getSystemStatistics(),
      );

  Future<PluginSystemStatisticsInformation> updateSystemStatistics() async {
    final ptrStatistics = await _takeSystemStatistics();
    state = state.copyWith(
      ptrStatistics: ptrStatistics,
      statistics: PluginSystemStatisticsInformation.fromPointer(ptrStatistics),
    );
    return state.statistics!;
  }

  Future<PluginSystemStatisticsInformation> getSystemStatistics() async {
    if (state.statistics == null) {
      return updateSystemStatistics();
    }
    return state.statistics!;
  }

  FutureOr<Pointer<PH_SYSTEM_BASIC_INFORMATION>>
  _getSystemBasicInformation() async {
    if (state.ptrSystemBasicInformation == null) {
      final address = await _hostApi.getSystemBasicInformation();
      return Pointer<PH_SYSTEM_BASIC_INFORMATION>.fromAddress(address);
    } else {
      return state.ptrSystemBasicInformation!;
    }
  }

  Future<void> update() async {
    final ptrStatistics = await _takeSystemStatistics();
    state = state.copyWith(
      processItems: await _takeCurrentProcesses(),
      ptrStatistics: ptrStatistics,
      statistics: PluginSystemStatisticsInformation.fromPointer(ptrStatistics),
      ptrSystemBasicInformation: await _getSystemBasicInformation(),
    );
  }

  bool get sortBySize => state.sortBySize;
  set sortBySize(bool value) {
    if (value == sortBySize) {
      return;
    }
    state = state.copyWith(sortBySize: value);
  }

  DataPicker get dataSetSelect => state.dataSetSelect;
  set dataSetSelect(DataPicker value) {
    if (value == dataSetSelect) {
      return;
    }
    state = state.copyWith(dataSetSelect: value);
  }

  bool get hideIdle => state.hideIdle;
  set hideIdle(bool value) {
    if (value == hideIdle) {
      return;
    }
    state = state.copyWith(hideIdle: value);
  }
}

extension StatisticsExt on ProcesssInfo {
  int get pageSize => 0x1000;

  double get cpu => statistics!.cpuUserUsage + statistics!.cpuKernelUsage;

  int get commitPages => statistics!.performance.committedPages * pageSize;
  int get commitLimit => statistics!.performance.commitLimit * pageSize;
  double get commitPagesFraction => commitPages / commitLimit;
  String get commitPagesPercentage => commitPagesFraction.toPercentageString();

  PH_SYSTEM_BASIC_INFORMATION get sysBasicInfo =>
      ptrSystemBasicInformation!.ref;

  int get totalMemory => sysBasicInfo.NumberOfPhysicalPages * pageSize;

  int get physicalMemory => totalMemory - freeMemory;
  double get physicalMemoryFraction {
    return physicalMemory / totalMemory;
  }

  int get freeMemory => statistics!.performance.availablePages * pageSize;
  double get freeMemoryFraction => freeMemory / totalMemory;

  int get ioReadOther =>
      statistics!.ioReadDelta.delta + statistics!.ioOtherDelta.delta;
  int get ioWrite => statistics!.ioWriteDelta.delta;
}

extension ToPercentageString on double {
  String toPercentageString([int fractionDigits = 2]) {
    return '${(this * 100).toStringAsFixed(fractionDigits)}%';
  }
}

extension ToBytesString on int {
  String toBytesString() {
    return bytesToString(this);
  }
}
