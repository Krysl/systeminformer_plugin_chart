import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/proc_items.dart';

part 'treemap.freezed.dart';
part 'treemap.g.dart';

class PidMapConverter
    implements JsonConverter<Map<Pid, bool>, Map<int, dynamic>> {
  const PidMapConverter();

  @override
  Map<Pid, bool> fromJson(Map<int, dynamic> json) =>
      json.map((key, value) => MapEntry(key.toPid(), value as bool));

  @override
  Map<int, dynamic> toJson(Map<Pid, bool> object) =>
      object.map((key, value) => MapEntry(key.pid, value));
}

@Freezed(fromJson: false, toJson: false)
abstract class TreeMapLayout with _$TreeMapLayout {
  factory TreeMapLayout({
    @PidMapConverter() @Default({}) Map<Pid, bool> disableMap,
    // OverlayEntry? overlayEntry,
  }) = _TreeMapLayout;
}

@riverpod
class TreeMapModel extends _$TreeMapModel {
  @override
  TreeMapLayout build() {
    return TreeMapLayout();
  }

  Map<Pid, bool> get disableMap => state.disableMap;

  bool toggleProcessVisiable(Pid pid) {
    final isDisabled = !(disableMap[pid] ?? false);
    state = state.copyWith(disableMap: {...disableMap, pid: isDisabled});
    return isDisabled;
  }

  bool isProcessVisiable(Pid pid) {
    return !((disableMap[pid]) ?? false);
  }
}
