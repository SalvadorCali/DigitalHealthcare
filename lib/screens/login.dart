import 'package:flutter/material.dart';
import 'package:thesis/widgets/appbar_button.dart';

class Login extends StatelessWidget {
  final openQRCodeScanner;
  final openEmergencyNumbers;
  final changeScreen;
  Login(this.openQRCodeScanner, this.openEmergencyNumbers, this.changeScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          AppBarButton(
              Icon(Icons.contact_phone_outlined), openEmergencyNumbers),
          AppBarButton(Icon(Icons.qr_code_scanner), openQRCodeScanner),
          AppBarButton(Icon(Icons.login), changeScreen),
        ],
      ),
      body: Center(child: Text("Login screen")),
    );
  }
}

printSomething() {
  print("Something");
}
