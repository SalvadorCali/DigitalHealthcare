import 'package:flutter/material.dart';
import 'package:thesis/screens/emergency_numbers.dart';
import 'package:thesis/screens/homepage.dart';
import 'package:thesis/screens/login.dart';
import 'package:thesis/screens/qr_code_scanner.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool logged = true;
  @override
  Widget build(BuildContext context) {
    return logged
        ? Homepage(openQRCodeScanner, openEmergencyNumbers, changeScreen)
        : Login(openQRCodeScanner, openEmergencyNumbers, changeScreen);
  }

  openQRCodeScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRCodeScanner()),
    );
  }

  openEmergencyNumbers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmergencyNumbers()),
    );
  }

  changeScreen() {
    setState(() {
      logged = !logged;
    });
  }
}
