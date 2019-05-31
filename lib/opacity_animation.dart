import 'package:flutter/material.dart';

/**
 * Created by Maker on 2019/5/31.
 * Describe:
 */

class OpacityAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _OpacityAniWidgetState();
  }
}

class _OpacityAniWidgetState extends State<OpacityAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> opacity;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });
  }

  Future _startAnimation() async {
    try {
      await _controller.repeat();
//
//      await _controller
//          .forward()
//          .orCancel;
//      await _controller
//          .reverse()
//          .orCancel;
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _initAni();
    _startAnimation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: opacity.value,
      child: new Container(
        color: Colors.red,
        height: 200.0,
        width: 200.0,
        child: new Center(
          child: new Text(
            'opacity',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}