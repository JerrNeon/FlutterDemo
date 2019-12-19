import 'package:flutter/material.dart';

class RouteAnimation {
  static const ANIMATION_FADE = 1; //渐变
  static const ANIMATION_SCALE = 2; //缩放
  static const ANIMATION_ROTATION = 3; //旋转
  static const ANIMATION_SCALE_ROTATION = 4; //缩放&旋转
  static const ANIMATION_SLIDE_LEFT_RIGHT = 5; //左右滑动
  static const ANIMATION_SLIDE_RIGHT_LEFT = 6; //右左滑动
  static const ANIMATION_SLIDE_TOP_BOTTOM = 7; //下上滑动
  static const ANIMATION_SLIDE_BOTTOM_TOP = 8; //上下滑动

  static RouteTransitionsBuilder build(
      {int animationType = ANIMATION_SLIDE_RIGHT_LEFT}) {
    return (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      if (animationType == ANIMATION_FADE) {
        return _fadeTransition(animation, child);
      } else if (animationType == ANIMATION_SCALE) {
        return _scaleTransition(animation, child);
      } else if (animationType == ANIMATION_ROTATION) {
        return _rotationTransition(animation, child);
      } else if (animationType == ANIMATION_SCALE_ROTATION) {
        return _scaleRotationTransition(animation, child);
      } else if (animationType == ANIMATION_SLIDE_LEFT_RIGHT) {
        return _slideTransitionLeft(animation, child);
      } else if (animationType == ANIMATION_SLIDE_RIGHT_LEFT) {
        return _slideTransitionRight(animation, child);
      } else if (animationType == ANIMATION_SLIDE_TOP_BOTTOM) {
        return _slideTransitionTop(animation, child);
      } else if (animationType == ANIMATION_SLIDE_BOTTOM_TOP) {
        return _slideTransitionBottom(animation, child);
      }
      return null;
    };
  }

  static FadeTransition _fadeTransition(Animation animation, Widget child) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }

  static ScaleTransition _scaleTransition(Animation animation, Widget child) {
    return ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      )),
      child: child,
    );
  }

  static RotationTransition _rotationTransition(
      Animation animation, Widget child) {
    return RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);
  }

  static RotationTransition _scaleRotationTransition(
      Animation animation, Widget child) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: child,
      ),
    );
  }

  static SlideTransition _slideTransitionLeft(
      Animation animation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);
  }

  static SlideTransition _slideTransitionRight(
      Animation animation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);
  }

  static SlideTransition _slideTransitionTop(
      Animation animation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);
  }

  static SlideTransition _slideTransitionBottom(
      Animation animation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);
  }
}
