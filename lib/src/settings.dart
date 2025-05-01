// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:logger/logger.dart';

import 'messages.dart';
import 'utils/logger.dart';

const PLUGIN_NAME = 'ProcessHacker.ProcessChart';
const SETTING_NAME_VSCODE_LAUNCH_JSON = '$PLUGIN_NAME.VSCode.launch.json';
const SETTING_NAME_DEBUG_LEVEL_SETTING = '$PLUGIN_NAME.debug.level';

/// add settings not setted in C++ code, just for convenience
/// FIXME: Assertion Error in [PhGetIntegerStringRefSetting](../../../systeminformer/phlib/settings.c#L322)
Future<void> initAdditionalSettings_bug() async {
  final SystemInformerHostApi hostApi = SystemInformerHostApi();
  await hostApi.addIntegerSetting(SETTING_NAME_DEBUG_LEVEL_SETTING, '0');
  await hostApi
      .getIntegerSetting(SETTING_NAME_DEBUG_LEVEL_SETTING)
      .then((debugLevel) async {
    debugLevel =
        debugLevel.clamp(Level.values.first.index, Level.values.last.index);
    await loggerInit(level: Level.values[debugLevel]);
  });
}

Future<void> initAdditionalSettings() async {
  Logger.level = Level.error;// TODO(krysl): fix bug above
  await loggerInit();
}
