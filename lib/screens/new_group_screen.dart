import 'package:flutter/material.dart';

class NewGroupScreen extends StatelessWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: const Color(0xff075e54),
          title:const Text('گروه جدید'),
        ) ,
        body:const Center(child:  Text('گروه جدید')),
      ),
    );
  }
}
