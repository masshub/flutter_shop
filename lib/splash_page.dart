import 'package:flutter/material.dart';

/**
 * Created by Maker on 2019/6/5.
 * Describe:
 */

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  AnimationController _animationController;
  final Tween distanceTween = Tween(begin: -200.0,end: 0.0);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: const Duration(seconds: 3));


  }
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
