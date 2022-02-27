import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: const Color(0xff075e54),
          title:const Text('تنظیمات'),
        ) ,
        body:const Center(child:  Text('تنظیمات')),
      ),
    );
  }
}
