import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartOptions: DartOptions(),
    cppOptions: CppOptions(namespace: 'SystemInformer'),
    cppHeaderOut: 'windows/runner/messages.g.h',
    cppSourceOut: 'windows/runner/messages.g.cpp',
    // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
    copyrightHeader: 'pigeons/copyright.txt',
    dartPackageName: 'system_informer_charts',
  ),
)
// #enddocregion config

// This file and ./messages_test.dart must be identical below this line.

// #docregion host-definitions
enum Code { one, two }

const pluginName = 'ProcessHacker.ProcessChart';

const showDebugWindows = '$pluginName.ShowDebugWindows';
const test = '$pluginName.TEST';

class MessageData {
  MessageData({required this.code, required this.data});
  String? name;
  String? description;
  Code code;
  Map<String?, String?> data;
}

class ProcessItemsRaw {
  /// PPH_PROCESS_ITEM *ProcessItems
  /// PULONG NumberOfProcessItems
  List<int> items;

  ProcessItemsRaw(this.items);
}

// ignore: camel_case_types
enum SettingType {
  stringSettingType,
  integerSettingType,
  integerPairSettingType,
  scalableIntegerPairSettingType
}

@HostApi()
abstract class SystemInformerHostApi {
  String getStringSetting(String key);
  int getIntegerSetting(String key);
  ProcessItemsRaw enumProcessItems();

  ///  VOID PhAddSetting(
  ///    _In_ PH_SETTING_TYPE Type,
  ///    _In_ PPH_STRINGREF Name,
  ///    _In_ PPH_STRINGREF DefaultValue
  ///  );
  void addSetting(SettingType type, String name, String defaultValue);

  /// PHAPPAPI
  /// HICON
  /// NTAPI
  /// PhGetImageListIcon(
  ///     _In_ ULONG_PTR Index,
  ///     _In_ BOOLEAN Large
  ///     );
  int getImageListIcon(int index, {bool isLarge = true});

  /// PHAPPAPI
  /// VOID
  /// NTAPI
  /// PhPluginGetSystemStatistics(
  ///     _Out_ PPH_PLUGIN_SYSTEM_STATISTICS Statistics
  ///     );
  int getSystemStatistics();

  /// typedef struct _PH_SYSTEM_BASIC_INFORMATION
  /// {
  ///     USHORT PageSize;
  ///     USHORT NumberOfProcessors;
  ///     ULONG MaximumTimerResolution;
  ///     ULONG NumberOfPhysicalPages;
  ///     ULONG AllocationGranularity;
  ///     ULONG_PTR MaximumUserModeAddress;
  ///     KAFFINITY ActiveProcessorsAffinityMask;
  /// } PH_SYSTEM_BASIC_INFORMATION, *PPH_SYSTEM_BASIC_INFORMATION;
  ///
  /// PHLIBAPI extern PH_SYSTEM_BASIC_INFORMATION PhSystemBasicInformation;
  int getSystemBasicInformation();

  @async
  bool sendMessage(MessageData message);
}
// #enddocregion host-definitions

// #docregion flutter-definitions
@FlutterApi()
abstract class MessageFlutterApi {
  String flutterMethod(String? aString);
  // String settingKeysToString(SettingKeys key);
}
// #enddocregion flutter-definitions
