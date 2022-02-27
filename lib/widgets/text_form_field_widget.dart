import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {required this.hint,
      required this.obscure,
      required this.icon,
      required this.validator,
      required this.onSaved});

  final String hint;
  final bool obscure;
  final IconData icon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintMaxLines: 1,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.teal)),
            prefixIcon: Icon(icon, color: Colors.white),
            hintText: hint,
            disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.tealAccent)),
            errorStyle: const TextStyle(color: Colors.tealAccent),
            focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.tealAccent)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.tealAccent)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.tealAccent)),
            border: const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.tealAccent)),
            hintStyle: const TextStyle(
                color: Colors.white, fontSize: 17, letterSpacing: 3)),
      ),
    );
  }
}
