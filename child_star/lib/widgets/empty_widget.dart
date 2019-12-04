import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final width;
  final height;

  EmptyWidget({this.width = 0.0, this.height = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
    );
  }
}
