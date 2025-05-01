import 'package:d4_hierarchy/d4_hierarchy.dart' as d4;
// ignore: implementation_imports
import 'package:d4_hierarchy/src/hierarchy/hierarchy.dart' show computeHeight;
import '../utils/logger.dart';
import 'proc_items.dart';

typedef ProcTreeNode = d4.HierarchyNode<ProcessItem>;

bool isRootNode(ProcTreeNode node) {
  assert(InvalidPid.root.pid.pid == 0, "root's pid should bi 0");
  return node.id == '0';
}

extension ProcTreeNodePolyfill on ProcTreeNode {
  void addChild(ProcTreeNode child) => (children ??= []).add(child);

  bool get isRoot => isRootNode(this);
}

const fakeItem = ProcessItemConst(name: '#fake', pid: -999999);
final fakeTreeNode = ProcTreeNode(fakeItem);
ProcTreeNode createProcTreeNode() => ProcTreeNode(fakeItem);

class ProcTree {
  ProcTreeNode root = ProcTreeNode(
    ProcessItemConst(name: '#Root', pid: InvalidPid.root.pid.pid),
  )..id = '0';

  final Map<Pid, ProcTreeNode> treeNodeMap = {};

  ProcTree.fromProcessItems(ProcessItems items) {
    _buildTree(items);
    _setDepth();
  }
  void _buildTree(ProcessItems items) {
    final entries = items.entires;

    treeNodeMap[0.toPid()] = root;

    for (final MapEntry(key: pid, value: item) in entries) {
      final ppid = item.parentProcessId.toPid();
      final node =
          (treeNodeMap[pid] ?? createProcTreeNode())
            ..id = pid.id
            ..data = item;
      logger.t(
        '_buildTree '
        '${item.pid.toStringAsFixed(6)} '
        '${item.name} '
        '${item.privateBytes} '
        '${item.parentProcessId}',
      );
      treeNodeMap[pid] = node;
      if (ppid.pid <= 0) {
        if (ppid.pid != pid.pid) {
          root.addChild(node);
        }
        continue;
      }
      if (items.existsPid(ppid)) {
        if (!treeNodeMap.containsKey(ppid)) {
          treeNodeMap[ppid] = createProcTreeNode()..id = ppid.id;
        }
        if (ppid.pid != pid.pid) {
          treeNodeMap[ppid]!.addChild(node);
        }
      } else {
        root.addChild(node);
      }
    }
    logger.t('-' * 20);
    assert(
      treeNodeMap.length == entries.length + 1,
      'build tree with ${treeNodeMap.length}, '
      'but entries.length=${entries.length}',
    );
  }

  void _setDepth() {
    ProcTreeNode node;
    final nodes = [root];

    while (nodes.isNotEmpty) {
      node = nodes.removeLast();
      final childs = node.children;
      if (childs != null && childs.isNotEmpty) {
        for (var i = childs.length - 1; i >= 0; --i) {
          nodes.add(
            (childs[i])
              ..parent = node
              ..parentId = node.id
              ..depth = node.depth + 1,
          );
        }
      }
    }
    root.eachBefore(computeHeight<ProcessItem, ProcTreeNode>);

    logger.t('~' * 20);
    root.eachBefore((node, index, thisArg, [that]) {
      if (node == root) {
        logger.t(' ${'  ' * node.depth}${node.data.name}');
      } else {
        logger.t(
          '${node.parentId == node.data.parentProcessId.toString() ? ' ' : 'x'}${'  ' * node.depth}'
          '${(node.id ?? '(null)').padLeft(6)} '
          '${(node.parentId ?? '(null)').padLeft(6)} '
          '${node.data.parentProcessId.toString().padLeft(6)} '
          '${node.data.name}',
        );
      }
    });
  }

  void addSelfToChildren(DataPicker dataPicker) {
    root.eachAfter((node, index, thisArg, [that]) {
      if ((node.children?.isNotEmpty ?? false) && node != root) {
        node.addChild(
          ProcTreeNode(node.data)
            ..id = '↓${node.id}'
            ..data = node.data
            ..value = dataPicker.pick(node.data),
        );
      }
    });
  }

  void removeIdleNode() {
    final idleNode = treeNodeMap[InvalidPid.systemIdleProcess.pid];
    idleNode?.parent?.children?.remove(idleNode);
  }

  int hashTree({String? debugInfo, int depth = 0}) {
    final List<num> values = [];
    root.eachBefore((node, index, thisArg, [that]) {
      values.add(node.value ?? 0);
    });
    final hash = Object.hashAll(values);
    logger.d('Treemap build() $debugInfo hash=${' ' * 9 * depth}$hash');
    return hash;
  }
}

String toDisplayString(
  ProcTreeNode node,
  DataPicker dataPicker, {
  bool selfOnly = false,
}) {
  final value = !selfOnly ? node.value! : dataPicker.pick(node.data);
  return dataPicker.toDisplayText(value);
}
