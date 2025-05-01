import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/misc.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
abstract class SettingsData with _$SettingsData {
  factory SettingsData({
    @Default(false) bool debugOn,
    Uri? vmServiceUri,
    @Default(Level.error) Level logLevel,
  }) = _SettingsData;
}

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  SettingsData build() {
    return SettingsData();
  }

  bool get isDebugOn => state.debugOn;
  set isDebugOn(bool newVal) => state = state.copyWith(debugOn: newVal);

  Level get logLevel => state.logLevel;
  set logLevel(Level val) {
    Logger.level = val;
    state = state.copyWith(logLevel: val);
  }

  Uri? get vmServiceUri => state.vmServiceUri;
  set vmServiceUri(Uri? uri) {
    state = state.copyWith(vmServiceUri: uri);
    ref.cacheFor(const Duration(days: 1));
  }
}
