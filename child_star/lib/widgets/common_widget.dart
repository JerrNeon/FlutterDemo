import 'package:child_star/common/resource_index.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final width;
  final height;

  EmptyWidget({this.width = 0.0, this.height = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

class DividerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const DividerWidget({
    Key key,
    this.width,
    this.height = MySizes.s_1,
    this.color,
  })  : assert(width == null || width >= 0.0),
        assert(height == null || height >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return width != null
        ? Container(
            color: color,
            width: width,
            height: height,
          )
        : Divider(
            color: color,
            height: height,
          );
  }
}

class VerticalDividerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const VerticalDividerWidget({
    Key key,
    this.width = MySizes.s_1,
    this.height,
    this.color,
  })  : assert(width == null || width >= 0.0),
        assert(height == null || height >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return height != null
        ? Container(
            color: color,
            width: width,
            height: height,
          )
        : VerticalDivider(
            color: color,
            width: width,
          );
  }
}

class PaddingWidget extends StatelessWidget {
  final double left;
  final double top;
  final double right;
  final double bottom;
  final Widget child;

  const PaddingWidget({
    Key key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: child,
    );
  }
}

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "no data",
        style: TextStyle(
          color: MyColors.c_686868,
          fontSize: MyFontSizes.s_14,
        ),
      ),
    );
  }
}
