import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

  @override
  void initState() {
    //_setPersistence();
    //Future<User> user = FirebaseAuth.instance.authStateChanges().first;
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        logged = false;
      });
    } else {
      setState(() {
        logged = true;
      });
    }
    super.initState();
  }

  _setPersistence() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
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
                    openQRCodeScanner, openEmergencyNumbersLogged, logout);
              } else {
                return Volunteer(logout);
              }
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          });
    } else {
      return Login(setLogged, openQRCodeScanner, openEmergencyNumbersNotLogged);
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

  openEmergencyNumbersLogged() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmergencyNumbers(true)),
    );
  }

  openEmergencyNumbersNotLogged() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmergencyNumbers(false)),
    );
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      logged = false;
    });
  }
}
