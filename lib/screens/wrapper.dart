import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thesis/screens/emergency_numbers.dart';
import 'package:thesis/screens/homepage.dart';
import 'package:thesis/screens/login.dart';
import 'package:thesis/screens/qr_code_scanner.dart';
import 'package:thesis/screens/volunteer.dart';
import 'package:thesis/services/database_service.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool logged = false;
  bool volunteer = false;
  // bool automatic = true;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() {
          logged = false;
        });
      }
      /* else {
        setState(() {
          logged = true;
        });
      } */
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (logged) {
      return FutureBuilder<bool>(
          future: DatabaseService().isUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return Homepage(
                    openQRCodeScanner, openEmergencyNumbers, logout);
              } else {
                return Volunteer(logout);
              }
            } else {
              print("Sono qui");
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          });
    } else {
      return Login(setLogged, openQRCodeScanner, openEmergencyNumbers);
    }
  }

  setLogged() {
    setState(() {
      logged = true;
    });
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

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
