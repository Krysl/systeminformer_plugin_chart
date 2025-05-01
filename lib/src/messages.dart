import 'messages.g.dart';

export 'messages.g.dart';

extension SystemInformerHostApiExt on SystemInformerHostApi {
  Future<void> addStringSetting(String name, String defaultValue) =>
      addSetting(SettingType.stringSettingType, name, defaultValue);

  Future<void> addIntegerSetting(String name, String defaultValue) =>
      addSetting(SettingType.integerSettingType, name, defaultValue);

  Future<void> addIntegerPairSetting(String name, String defaultValue) =>
      addSetting(SettingType.integerPairSettingType, name, defaultValue);

  Future<void> addScalableIntegerPairSetting(
    String name,
    String defaultValue,
  ) =>
      addSetting(
        SettingType.scalableIntegerPairSettingType,
        name,
        defaultValue,
      );
}
