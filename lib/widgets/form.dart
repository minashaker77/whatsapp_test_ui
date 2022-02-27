import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/widgets/text_form_field_widget.dart';
import 'package:validators/validators.dart';

class FormFieldArea extends StatelessWidget {
  final formKey;

  const FormFieldArea(
      {required this.formKey,required this.emailOnSaved,required this.passwordOnSaved});

  final void Function(String?)? emailOnSaved;
  final void Function(String?)? passwordOnSaved;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            hint: 'ایمیل کاربری',
            obscure: false,
            icon: Icons.person,
            onSaved: emailOnSaved,
            validator: (String? value) {
              if (!isEmail(value!)) {
                return ' ایمیل معتبر را وارد کنید.';
              }
            },
          ),
          TextFormFieldWidget(
            onSaved: passwordOnSaved,
            icon: Icons.lock,
            hint: 'پسورد',
            obscure: true,
            validator: (String? value) {
              if (value!.length < 5) {
                return 'پسورد نباید کمتر از 6 کاراکتر باشد';
              }
            },
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'آیا هیچ اکانتی ندارید؟ عضویت',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
