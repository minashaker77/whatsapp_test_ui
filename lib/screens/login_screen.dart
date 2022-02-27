import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/animations/signin_animation.dart';
import 'package:whatsapp_test_ui/services/auth_service.dart';
import 'package:whatsapp_test_ui/widgets/form.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController loginController;
  late String _emailValue;
  late String _passwordValue;

  void Function(String?)? emailOnSaved(String? value) {
    _emailValue = value!;
  }

  void Function(String?)? passwordOnSaved(String? value) {
    _passwordValue = value!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.black,
          Color(0xff075e54),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/whatsapp-background-image.jpg'),
                      repeat: ImageRepeat.repeat),
                ),
              ),
            ),
            FormFieldArea(
              formKey: formKey,
              emailOnSaved: emailOnSaved,
              passwordOnSaved: passwordOnSaved,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      // await loginController.forward();
                      // await loginController.reverse();
                      formKey.currentState!.save();
                      sendDataForLogin();
                    }
                  },
                  child: SignInAnimation(
                    controller: loginController.view,
                  )),
            )
          ],
        ),
      ),
    );
  }

  sendDataForLogin() async {
    await loginController.animateTo(0.150);

    Map response = await AuthServices()
        .sendDataToLogin({"email": _emailValue, "password": _passwordValue});
    if (response['status'] == 'success') {
      await storeUserData(response['data']);
      await loginController.forward();
      Navigator.pushReplacementNamed(context, '/home_screen');
    } else {
      await loginController.reverse();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['data'],
            style: const TextStyle(fontFamily: 'Vazir'),
          ),
        ),
      );
    }
  }

  Future storeUserData(Map userData) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['api_token']);
    await prefs.setInt('user.user_id', userData['user_id']);
  }


}
