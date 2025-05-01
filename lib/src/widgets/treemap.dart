// ignore_for_file: unnecessary_null_comparison

import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:d4_hierarchy/d4_hierarchy.dart' as d4;
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:d4_hierarchy/src/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/icon.dart';
import '../model/proc_items.dart';
import '../model/proc_tree.dart';
import '../provider/processes.dart';
import '../provider/settings.dart';
import '../provider/treemap.dart';
import '../utils/d4.dart';
import '../utils/misc.dart';

extension ToStringFixedLen on int {
  String toFixedLen([int len = 6]) => toString().padLeft(len);
}

void preOrder<T>(
  d4.HierarchyNode<T> node,
  void Function(T node, int depth) visit, [
  int depth = 0,
]) {
  visit(node.data, depth);
  if (node.children != null && node.children!.isNotEmpty) {
    for (final child in node.children!) {
      preOrder(child, visit, depth + 1);
    }
  }
}

final Map<String, Color> colorMap = {};

class Treemap extends HookConsumerWidget {
  final bool enableDrilldown;
  final ProcesssInfo treemapConfig;

  const Treemap({
    required this.treemapConfig,
    this.enableDrilldown = false,
    super.key,
  });

  // late bool _isLightTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final ThemeData themeData = Theme.of(context);
    // _isLightTheme = themeData.colorScheme.brightness == Brightness.light;

    final ProcesssInfo(
      processItems: procItems,
      dataSetSelect: dataPicker,
      sortBySize: sortBySize,
      hideIdle: hideIdle,
    ) = treemapConfig;
    final procTree = ProcTree.fromProcessItems(procItems!);

    if (hideIdle) {
      procTree.removeIdleNode();
    }

    final root = procTree.root..sum(dataPicker.pick);

    procTree.addSelfToChildren(dataPicker);

    if (sortBySize) {
      root.sort((a, b) => ((b.value ?? 0) - (a.value ?? 0)).sign.toInt());
    }
    return Padding(
      padding: const EdgeInsets.all(1),
      child: TreeMapChartBox(hierarchyData: root, dataPicker: dataPicker),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<bool>('enableDrilldown', enableDrilldown),
    );
  }
}

class TreeMapDebugView extends ConsumerStatefulWidget {
  const TreeMapDebugView({
    required this.nodes,
    required this.dataPicker,
    this.root,
    this.getValue,
    super.key,
  });

  final List<ProcTreeNode> nodes;

  final ProcTreeNode? root;
  final DataPicker dataPicker;
  final double Function(ProcTreeNode node)? getValue;

  @override
  ConsumerState<TreeMapDebugView> createState() => _TreeMapDebugViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ProcTreeNode>('nodes', nodes))
      ..add(IterableProperty<ProcTreeNode>('root', root?.descendants()))
      ..add(EnumProperty<DataPicker>('dataPicker', dataPicker))
      ..add(
        ObjectFlagProperty<double Function(ProcTreeNode node)?>.has(
          'getValue',
          getValue,
        ),
      );
  }
}

class _TreeMapDebugViewState extends ConsumerState<TreeMapDebugView> {
  TextEditingController filterController = TextEditingController();
  List<int> filterPids = [];

  @override
  Widget build(BuildContext context) {
    ref.watch(treeMapModelProvider);
    final model = ref.read(treeMapModelProvider.notifier);
    final nodes = widget.nodes;

    final nodeNum = nodes.where(valid).length;
    final filteredNodesForDebugSwitchs =
        filterPids.isEmpty
            ? nodes
            : nodes.where((node) {
              final pid = node.data.pid;
              if (filterPids.contains(pid)) {
                return true;
              }
              return false;
            }).toList();

    void doFilter() {
      setState(() {
        filterPids = //
            filterController.text
                .split(RegExp(r'[,\ ]'))
                .map(int.tryParse)
                .whereType<int>()
                .toList();
      });
    }

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: Text('showed $nodeNum/${nodes.length}'),
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Tooltip(
              message: 'Enter the PID(s) to filter (separated by commas)',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        hintText:
                            'Enter the PID(s) to filter (separated by commas)',
                        hintStyle: TextStyle(fontSize: 8),
                      ),
                      controller: filterController,
                      onEditingComplete: doFilter,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      onPressed: doFilter,
                      icon: Icon(Icons.filter),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredNodesForDebugSwitchs.length,
            itemBuilder: (context, index) {
              final node = filteredNodesForDebugSwitchs[index];
              final item = node.data;
              final pid = item.pid;
              final depth = node.depth;

              final title = ListTile(
                tileColor: valid(node) ? Colors.green[200] : Colors.grey,
                selectedTileColor: Colors.red[200],
                minTileHeight: 3,
                title: Padding(
                  padding: EdgeInsets.only(left: depth * 10),
                  child: Text(
                    '$pid '
                    '${item.name} '
                    '${item.cpu.toPercentageString()} '
                    '${bytesToString(item.privateBytes)} '
                    ' (${node.x0}, ${node.y0}) '
                    'w=${(node.x1 ?? 0) - (node.x0 ?? 0)}, h=${(node.y1 ?? 0) - (node.y0 ?? 0)}',
                    style: TextStyle(
                      // color: _isLightTheme ? Colors.black : Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
                onTap: () {
                  model.toggleProcessVisiable(pid.toPid());
                },
                selected:
                    (pid != null) && !model.isProcessVisiable(pid.toPid()),
              );
              return title;
            },
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<TextEditingController>(
          'filterController',
          filterController,
        ),
      )
      ..add(IterableProperty<int>('filterPids', filterPids));
  }
}

class TreeMapChartBox extends ConsumerWidget {
  const TreeMapChartBox({
    required this.hierarchyData,
    required this.dataPicker,
    this.debugPanelWidth = 200,
    super.key,
  });
  final DataPicker dataPicker;
  final ProcTreeNode hierarchyData;
  final double debugPanelWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsProvider.select((value) => value.debugOn));
    final settings = ref.read(settingsProvider.notifier);
    final isDebugOn = settings.isDebugOn;
    return LayoutBuilder(
      builder: (context, constraints) {
        final trueDebugPanelWidth = isDebugOn ? debugPanelWidth : 0;
        final d4.Treemap<ProcessItem> treeMap = //
            d4.Treemap<ProcessItem>()
              ..size = [
                constraints.maxWidth - trueDebugPanelWidth,
                constraints.maxHeight,
              ]
              ..constPaddingOuter(3)
              ..paddingTop = constant(19)
              ..constPaddingInner(3)
              ..round = true;
        final root = treeMap(hierarchyData);

        final List<ProcTreeNode> nodes = root.descendants();

        final treeMapChart = TreeMapChart(
          nodes: nodes,
          getColor: getColor,
          dataPicker: dataPicker,
        );
        if (!isDebugOn) {
          return treeMapChart;
        } else {
          return Center(
            child: Row(
              children: [
                SizedBox(
                  width: debugPanelWidth,
                  child: TreeMapDebugView(
                    nodes: nodes,
                    dataPicker: dataPicker,
                    root: root,
                  ),
                ),
                Expanded(child: treeMapChart),
              ],
            ),
          );
        }
      },
    );
  }

  Color getColor(ProcTreeNode node) {
    double getLightness([int? lv]) => 1.3 - pow(0.95, lv ?? 0).toDouble() - 0.1;
    HSLColor getRandomColor([int? lv]) =>
        HSLColor.fromAHSL(1, random.nextDouble() * 360, 0.5, getLightness(lv));
    final name = node.data.name ?? '';

    if (colorMap.containsKey(name)) {
      return colorMap[name]!;
    }
    colorMap[name] = //
        getRandomColor(node.depth)
            .withLightness(getLightness(node.depth)) //
            .toColor();
    return colorMap[name]!;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<DataPicker>('dataPicker', dataPicker));
  }
}

class TreeMapChart extends ConsumerStatefulWidget {
  const TreeMapChart({
    required this.nodes,
    required this.dataPicker,
    this.getColor, // TODO(krysl): upgrade to process theme (include icon caches)
    super.key,
  });

  final List<ProcTreeNode> nodes;
  final Color Function(ProcTreeNode node)? getColor;
  final DataPicker dataPicker;

  @override
  ConsumerState<TreeMapChart> createState() => _TreeMapChartState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ProcTreeNode>('nodes', nodes))
      ..add(
        ObjectFlagProperty<Color Function(ProcTreeNode node)?>.has(
          'getColor',
          getColor,
        ),
      );
  }
}

class _TreeMapChartState extends ConsumerState<TreeMapChart> {
  @override
  Widget build(BuildContext context) {
    final nodes = widget.nodes;
    final firstIsRoot = nodes.first.isRoot;
    final root = firstIsRoot ? nodes.first : nodes.firstWhere(isRootNode);
    final nonRootNodes =
        firstIsRoot ? nodes.skip(1) : nodes.skipWhile(isRootNode);
    final filteredNodes = nonRootNodes.where(valid);

    ref.watch(treeMapModelProvider);
    final model = ref.read(treeMapModelProvider.notifier);
    final dataPicker = widget.dataPicker;

    return Stack(
      children: [
        createTreeMapRootTile(root),
        for (final node in filteredNodes)
          if (node.depth == 0 || model.isProcessVisiable(node.data.pid.toPid()))
            ...node.apply((left, top, width, height) {
              return treeMapTile(
                widget: widget,
                node: node,
                width: width,
                height: height,
                context: context,
                ref: ref,
                dataPicker: dataPicker,
              ).map(
                (e) => Positioned(
                  left: left,
                  top: top,
                  width: width,
                  height: height,
                  child: e,
                ),
              );
            }),
      ],
    );
  }

  Widget createTreeMapRootTile(ProcTreeNode node) => node.apply(
    (left, top, width, height) => Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: ColoredBox(
        color:
            widget.getColor?.call(node) ??
            HSLColor.fromAHSL(
              1,
              random.nextDouble() * 360,
              1,
              1.3 - pow(0.95, node.depth).toDouble(),
            ).toColor(),
        child: HookConsumer(
          builder: (context, ref, child) {
            final statistics = ref.watch(
              processesProvider.select((value) => value.statistics),
            );
            final info = ref.read(processesProvider);
            String text = '/';
            if (statistics != null && info != null) {
              text = [
                'Cpu: ${info.cpu.toPercentageString()}',
                'CommitPages: ${info.commitPages.toBytesString()} (${info.commitPagesPercentage})',
                'Physical memory: ${info.physicalMemory.toBytesString()} (${info.physicalMemoryFraction.toPercentageString()})',
                'Free memory: ${info.freeMemory.toBytesString()} (${info.freeMemoryFraction.toPercentageString()})',
                'I/O R+O: ${info.ioReadOther.toBytesString()} W: ${info.ioWrite.toBytesString()}',
              ].join(' ' * 10);
            } else if (info.briefInfo != null) {
              text = info.briefInfo!;
            }
            return Text(
              text,
              style: TextStyle(
                // color: _isLightTheme ? Colors.black : Colors.white,
                color: Colors.white,
                fontSize: 16,
              ),
            );
          },
        ),
      ),
    ),
  );
}

List<Widget> treeMapTile({
  required TreeMapChart widget,
  required ProcTreeNode node,
  required double width,
  required double height,
  required BuildContext context,
  required WidgetRef ref,
  required DataPicker dataPicker,
}) {
  final item = node.data;

  Widget? details;
  final textStyle = TextStyle(
    // color: _isLightTheme ? Colors.black : Colors.white,
    color: Colors.white,
    fontSize: 10,
  );
  if (width > 50 && height > 14) {
    final text =
        [
          if (node.id != null && item.pid > 0) //
            '${item.pid.toFixedLen()} ',
          if (item.name!.isNotEmpty) //
            '${item.name} ',
          toDisplayString(node, dataPicker, selfOnly: true),
          if (node.children?.isNotEmpty ?? false)
            '/${toDisplayString(node, dataPicker)}',
          '\n',
          if (node.id != '0' && (node.children?.isEmpty ?? true) && height > 20)
            '${item.commandLine?.split(' --').join('\n${' ' * 10}--')}\n',
        ].join();

    if (item.iconEntry != null) {
      final iconEntry = item.iconEntry!;
      final iconIndex = iconEntry.smallIconIndex;
      final AsyncValue<Uint8List?> png = ref.watch(
        getIconPngProvider(iconIndex, isLarge: false),
      );
      details = Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child:
                  png.hasValue
                      ? Image.memory(png.value!, height: 16)
                      : Text(iconIndex.toString()),
            ),
            TextSpan(text: text),
          ],
        ),
        style: textStyle,
        overflow: TextOverflow.fade,
        softWrap: false,
      );
    } else {
      details = Text(text, style: textStyle);
    }
  }
  final list = [
    if (width > 16 &&
        height > 16 &&
        item.iconEntry != null &&
        (node.children == null || node.children!.isEmpty))
      ClipRect(
        child: ref
            .watch(getIconPngProvider(item.iconEntry!.largeIconIndex))
            .when(
              data:
                  (png) =>
                      png != null
                          ? ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: FittedBox(child: Image.memory(png)),
                          )
                          : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
      ),
    Opacity(
      opacity: 0.75,
      child: ColoredBox(
        color:
            widget.getColor?.call(node) ??
            HSLColor.fromAHSL(
              1,
              random.nextDouble() * 360,
              1,
              1.3 - pow(0.95, node.depth).toDouble(),
            ).toColor(),
        child: details,
      ),
    ),
  ];
  return list;
}
