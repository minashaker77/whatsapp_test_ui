import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/screens/home_screen.dart';
import 'package:whatsapp_test_ui/screens/login_screen.dart';
import 'package:whatsapp_test_ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Vazir',
        primaryColor: const Color(0xff075e54),
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        "/home_screen": (context) => Directionality(
            textDirection: TextDirection.rtl, child: HomeScreen()),
        "/login_screen": (context) => Directionality(
            textDirection: TextDirection.rtl, child: LoginScreen()),
      },
    );
  }
}
