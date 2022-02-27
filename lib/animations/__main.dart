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
        debugShowCheckedModeBanner: false,
        title: 'واتساپ',
        home: AnimationTest());
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
  late Animation<double> animation;
  double largest = min(50.0, 300.0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    animation = Tween(begin: largest, end: 300.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack));
    controller.addListener(() {
      if (controller.isCompleted) {
        controller.reverse();
      } else if (controller.isDismissed) {
        controller.forward();
      }
    });
  }

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Container(
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo());
  }

  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: _isExpanded ? 90 : 1,
              child: AnimatedBuilder(
                  animation: controller, builder: _animationBuilder),
            ),
            MaterialButton(
              onPressed: () {
                controller.forward();
              },
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('run'),
              color: Colors.blue,
              height: 40,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
