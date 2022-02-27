import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> buttonPressedAnimation;
  final Animation<double> buttonZoomOut;

  SignInAnimation({required this.controller})
      : buttonPressedAnimation = Tween(begin: 280.0, end: 60.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.150),
          ),
        ),
        buttonZoomOut = Tween(begin: 70.0, end: 1000.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.550, 0.999, curve: Curves.bounceOut),
          ),
        );

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return buttonZoomOut.value <= 300.0
        ? Container(
            width: buttonZoomOut.value == 70
                ? buttonPressedAnimation.value
                : buttonZoomOut.value,
            height: buttonZoomOut.value == 70 ? 60 : buttonZoomOut.value,
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
                borderRadius: buttonZoomOut.value < 400
                    ? BorderRadius.circular(30)
                    : BorderRadius.circular(0),
                color: const Color(0xff075e54)),
            child: buttonPressedAnimation.value > 75
                ? const Center(
                        child: Text(
                          'ورود',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      )
                : buttonZoomOut.value < 300.0
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                : null)
        : Container(
            width: buttonZoomOut.value,
            height: buttonZoomOut.value,
            decoration: BoxDecoration(
                shape: buttonZoomOut.value < 500.0
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: const Color(0xff075E54)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _animationBuilder);
  }
}
