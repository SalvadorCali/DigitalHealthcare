import 'package:flutter/material.dart';
import 'package:thesis/widgets/appbar_button.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          AppBarButton(Icon(Icons.contact_phone_outlined), printSomething),
          AppBarButton(Icon(Icons.qr_code_scanner), printSomething),
        ],
      ),
      body: Text("Login screen"),
    );
  }
}

printSomething() {
  print("Something");
}
