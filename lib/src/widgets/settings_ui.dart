import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../model/icon.dart';
import '../provider/settings.dart';

class SettingsUI extends HookConsumerWidget {
  const SettingsUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsProvider);
    final settings = ref.read(settingsProvider.notifier);

    final iconIndexTextControl = useTextEditingController();

    final image = useState<Image?>(null);
    return SizedBox(
      width: 400,
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Debug: '),
              Spacer(),
              Switch(
                value: settings.isDebugOn,
                onChanged: (val) {
                  settings.isDebugOn = val;
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Log Level:'),
              Spacer(),
              DropdownButton<Level>(
                value: settings.logLevel,
                items:
                    Level.values
                        .map(
                          (e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)),
                        )
                        .toList(),
                onChanged: (val) {
                  if (val != null) {
                    settings.logLevel = val;
                  }
                },
              ),
            ],
          ),
          if (kDebugMode)
            Row(
              children: [
                Text('VM service uri:'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    unawaited(
                      Clipboard.setData(
                        ClipboardData(
                          text: settings.vmServiceUri?.toString() ?? 'x',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    settings.vmServiceUri?.toString() ??
                        'get vm service uri failed',
                  ),
                ),
              ],
            ),

          Row(
            children: [
              Text('get icon by index: '),
              Spacer(),
              SizedBox(
                height: 30,
                width: 100,
                child: TextField(
                  controller: iconIndexTextControl,
                  onEditingComplete: () {
                    final index = int.tryParse(iconIndexTextControl.text);
                    if (index == null) {
                      return;
                    }

                    unawaited(
                      getIconPngData(index).then((bytes) {
                        if (bytes != null) {
                          image.value = Image.memory(bytes);
                        }
                      }),
                    );
                  },
                ),
              ),
              ValueListenableBuilder<Image?>(
                valueListenable: image,
                builder: (context, img, child) {
                  if (img != null) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: img,
                    );
                  } else {
                    return const Text('No image available');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
