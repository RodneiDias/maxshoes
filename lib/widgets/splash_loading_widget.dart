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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/shoes.gif'),
        ],
      ),
    );
  }
}
