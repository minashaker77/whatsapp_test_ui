import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/models/model.dart';
import 'package:whatsapp_test_ui/screens/single_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  _navigateAndDisplaySomeMessage(context, chatData[index]);
                },
                child: Container(
                  decoration:const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.grey)),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(chatData[index].photo),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chatData[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          chatData[index].time,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Text(chatData[index].message),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

_navigateAndDisplaySomeMessage(BuildContext context, ChatModel data) async {
  final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => SingleChatScreen(data: data)));
  print(result);
}
