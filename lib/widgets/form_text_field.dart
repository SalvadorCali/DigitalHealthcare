import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hint;
  final String error;
  final bool isPassword;
  FormTextField(
      this.controller, this.icon, this.hint, this.error, this.isPassword);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) => (value == null || value.isEmpty) ? error : null,
        decoration: InputDecoration(
          icon: icon,
          hintText: hint,
          contentPadding: EdgeInsets.only(bottom: 3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
