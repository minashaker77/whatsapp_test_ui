import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/models/model.dart';

class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({Key? key, required this.data}) : super(key: key);

  final ChatModel data;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff075e54),
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 'سلام ${data.name}');
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data.photo),
                  ),
                ),
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, 'سلام ${data.name}');
              return false;
            },
            child: Center(
              child: Text('چت ' + data.name),
            ),
          ),
        ));
  }
}
