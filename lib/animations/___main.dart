import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: AnimationTest());
  }
}

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key? key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  _playAnimation()async{
    try{
      await controller.forward();
      await controller.reverse();
    } on TickerCanceled{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _playAnimation();
          },
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                color: Colors.black.withOpacity(0.1)),
            child: StaggerAnimation(controller: controller.view),
          ),
        ),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({required this.controller})
      : opacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.100, curve: Curves.ease),
          ),
        ),
        width = Tween(begin: 50.0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.125, 0.250, curve: Curves.ease),
          ),
        ),
        height = Tween(begin: 50.0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 0.375, curve: Curves.ease),
          ),
        ),
        padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16),
          end: const EdgeInsets.only(bottom: 75),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 0.375, curve: Curves.ease),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4),
          end: BorderRadius.circular(300),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.375, 0.500, curve: Curves.ease),
          ),
        ),
        color = ColorTween(begin: Colors.indigo[200], end: Colors.pink[200])
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.500, 0.750, curve: Curves.ease),
          ),
        );

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: buildAnimation);
  }

  Widget buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.pinkAccent, width: 3),
              borderRadius: borderRadius.value,
              color: color.value),
        ),
      ),
    );
  }
}
