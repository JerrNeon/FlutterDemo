import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///类似Material组件带滑动效果的头部
class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CustomSliverPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  })  : assert(minHeight != null),
        assert(maxHeight != null),
        assert(child != null),
        assert(minHeight <= maxHeight),
        super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  // 返回展示的内容，如果内容固定可以直接在这定义，如果需要可扩展，这边通过传入值来定义
  @override
  double get maxExtent => maxHeight; // 返回最大高度

  @override
  double get minExtent => minHeight; // 返回最小高度

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    // 是否需要更新，这里我们定义当高度范围和展示内容被替换的时候进行刷新界面
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}

///类似Material组件带滑动效果的头部(TabBar)
class TabBarSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  BannerWidget ban;

  TabBarSliverPersistentHeaderDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return tabBar;
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
