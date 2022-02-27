import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:whatsapp_test_ui/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkLogin();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacementNamed(context, "/home_screen");
  }

  // _navigateToLogin() async {
  //   await Future.delayed(const Duration(seconds: 2), () {});
  //   Navigator.pushReplacementNamed(context, "/login_screen");
  // }

  // checkLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? apiToken = prefs.getString('user.api_token');
  //   // if (apiToken == null) _navigateToHome();
  //   if (await checkConnectionInternet()) {
  //     await AuthServices.checkApiToken(apiToken!)
  //         ? _navigateToLogin()
  //         : _navigateToHome();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         duration: const Duration(hours: 24),
  //         content: GestureDetector(
  //           onTap: () {
  //             ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //             checkLogin();
  //           },
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: const [
  //               Text(
  //                 'از اتصال دستگاه به اینترنت مطمئن شوید',
  //                 style: TextStyle(fontFamily: 'Vazir'),
  //               ),
  //               Icon(Icons.wifi_lock, color: Colors.white)
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Future<bool> checkConnectionInternet() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   return connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff075e54),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
