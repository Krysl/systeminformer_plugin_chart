import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/messages.dart';
import 'src/model/csv.dart';
import 'src/model/proc_items.dart';
import 'src/provider/processes.dart';
import 'src/provider/settings.dart';
import 'src/settings.dart';
import 'src/utils/debug.dart';
import 'src/widgets/settings_ui.dart';
import 'src/widgets/treemap.dart';

class _ExampleFlutterApi implements MessageFlutterApi {
  @override
  String flutterMethod(String? aString) {
    return aString ?? '';
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MessageFlutterApi.setUp(_ExampleFlutterApi());
  await initAdditionalSettings();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Process Chart'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    unawaited(
      setVmServiceUri().then((uri) {
        ref.read(settingsProvider.notifier).vmServiceUri = uri;
      }),
    );
    unawaited(ref.read(processesProvider.notifier).update());
  }

  @override
  Widget build(BuildContext context) {
    final debugOn = ref.watch(settingsProvider.select((e) => e.debugOn));
    final processesInfo = ref.watch(processesProvider);
    final processes = ref.read(processesProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: debugOn,
                  child: IconButton(
                    onPressed: () {
                      processes.updateCsvProcesses(testCsvPath);
                    },
                    icon: const Icon(Icons.science),
                    tooltip:
                        'show the test csv ${File(testCsvPath).absolute.path}',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    unawaited(
                      FilePicker.platform.pickFiles().then((result) {
                        if (result != null) {
                          final csvPath = result.files.single.path!;
                          processes.updateCsvProcesses(csvPath);
                        }
                      }),
                    );
                  },
                  icon: const Icon(Icons.folder_open),
                  tooltip: 'open a csv saved by SystemInformer',
                ),
                IconButton(
                  onPressed: () {
                    unawaited(processes.update());
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'get the current processes now',
                ),
                SizedBox(
                  height: 30,
                  child: ColoredBox(
                    color:
                        Color.lerp(
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.black,
                          0.03,
                        )!,
                    child: DropdownButton<DataPicker>(
                      value: processes.dataSetSelect,
                      items:
                          DataPicker.values.map((e) {
                            return DropdownMenuItem<DataPicker>(
                              value: e,
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                e.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          processes.dataSetSelect = value;
                        }
                      },
                      focusColor: Theme.of(context).scaffoldBackgroundColor,
                      underline: SizedBox.shrink(),
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    const Text('Sort by Size'),
                    SizedBox(
                      height: 20,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          splashRadius: 4,
                          value: processes.sortBySize,
                          onChanged: (value) {
                            processes.sortBySize = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    const Text('Hide Idle'),
                    SizedBox(
                      height: 20,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          splashRadius: 4,
                          value: processes.hideIdle,
                          onChanged: (value) {
                            processes.hideIdle = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    unawaited(
                      showDialog<void>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Debug'),
                            content: SettingsUI(),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.bug_report_outlined),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: _createTreeMap(processesInfo), //
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTreeMap(ProcesssInfo info) {
    if (info.processItems != null) {
      return Treemap(treemapConfig: info);
    } else {
      return SizedBox.square(
        dimension: 100,
        child: CircularProgressIndicator(),
      );
    }
  }
}
