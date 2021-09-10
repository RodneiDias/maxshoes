import 'dart:async';

import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  get image => null;

  void Function()? get handleTimeout => null;

  startTimeout() async {
    var duration = const Duration(seconds: 4);
    return new Timer(duration, handleTimeout!);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color(0xff89c2d9),
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff014f86)
              ],
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/shoes1.gif'),
          ],
        ),
      ),
    );
  }
}
