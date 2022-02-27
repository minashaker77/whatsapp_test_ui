import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_test_ui/screens/call_screen.dart';
import 'package:whatsapp_test_ui/screens/camera_screen.dart';
import 'package:whatsapp_test_ui/screens/chat_screen.dart';
import 'package:whatsapp_test_ui/screens/new_group_screen.dart';
import 'package:whatsapp_test_ui/screens/settings_screen.dart';
import 'package:whatsapp_test_ui/screens/news_screen.dart';
import 'package:whatsapp_test_ui/screens/create_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  late Map<String, SliverAppBar> appBarList;
  String _currentAppBar = 'mainAppBar';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    SliverAppBar mainAppBar = SliverAppBar(
      floating: true,
      pinned: true,
      title: const Text('واتساپ', style: TextStyle(fontSize: 18)),
      backgroundColor: const Color(0xff075e54),
      elevation: 5,
      actions: [
        Container(
            margin: const EdgeInsets.only(left: 8),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentAppBar = 'searchAppBar';
                  });
                },
                child: const Icon(Icons.search))),
        Container(
            margin: const EdgeInsets.only(left: 8),
            child: PopupMenuButton(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onSelected: (String choose) async {
                if (choose == 'new_Group') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewGroupScreen()));
                } else if (choose == 'settings') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                } else if (choose == 'logout') {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.remove('user.api_token');
                  Navigator.pushReplacementNamed(context, '/login_screen');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      value: 'new_Group',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('گروه جدید'),
                        ],
                      )),
                  PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('تنظیمات'),
                        ],
                      )),
                  PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('خروج'),
                        ],
                      )),
                ];
              },
            )),
      ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: tabController,
        labelStyle: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'Vazir'),
        tabs: const [
          Tab(icon: Icon(Icons.camera_alt)),
          Tab(
            text: 'چت ها',
          ),
          Tab(text: 'اخبار'),
          Tab(text: 'تماس ها'),
        ],
      ),
    );
    SliverAppBar searchAppBar = SliverAppBar(
      pinned: true,
      title: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'جست و جو کنید ...',
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 5,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            _currentAppBar = 'mainAppBar';
          });
        },
        child: const Icon(
          Icons.arrow_back,
          color: Color(0xff075e54),
        ),
      ),
    );
    appBarList = <String, SliverAppBar>{
      'mainAppBar': mainAppBar,
      'searchAppBar': searchAppBar,
    };
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.start,
                title: const Text('آیا از خروج مطمئن هستید؟'),
                content: const Text('برای خروج روی گزینه بله بزنید'),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('خیر'),
                  ),
                  MaterialButton(
                    onPressed: () => exit(0),
                    child: const Text('بله'),
                  ),
                ],
              ),
            ));
    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [appBarList[_currentAppBar]!];
            },
            body: _currentAppBar == 'mainAppBar'
                ? TabBarView(
                    controller: tabController,
                    children: const [
                      CameraScreen(),
                      ChatScreen(),
                      NewsScreen(),
                      CallScreen()
                    ],
                  )
                : Column(
                    children: [
                      const Text('Search'),
                      MaterialButton(
                          child: const Text('برگشت'),
                          onPressed: () {
                            return Navigator.pop(context);
                          }),
                    ],
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 14,
          ),
        ),
      ),
    ));
  }
}
