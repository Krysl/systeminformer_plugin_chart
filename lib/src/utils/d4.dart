import 'package:d4_hierarchy/d4_hierarchy.dart' as d4;

// ignore: strict_raw_type
extension HierarchyNodeHelper on d4.HierarchyNode {
  double get left => x0!.toDouble();
  double get right => x1!.toDouble();
  double get top => y0!.toDouble();
  double get down => y1!.toDouble();
  double get width => right - left;
  double get height => down - top;
  T apply<T>(
    T Function(
      double left,
      double top,
      double width,
      double height,
    ) callback,
  ) =>
      callback(left, top, width, height);
}

bool valid<T>(d4.HierarchyNode<T> node) {
  final d4.HierarchyNode(
    x0: left,
    x1: right,
    y0: top,
    y1: down,
  ) = node;

  if (left == null || right == null || top == null || down == null) {
    return false;
  }

  final width = right - left;
  final height = down - top;
  if (left >= 0 && top >= 0 && width > 0 && height > 0) {
    return true;
  } else {
    return false;
  }
}
