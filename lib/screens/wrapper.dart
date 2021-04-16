import 'package:flutter/material.dart';
import 'package:thesis/screens/emergency_numbers.dart';
import 'package:thesis/screens/homepage.dart';
import 'package:thesis/screens/login.dart';
import 'package:thesis/screens/qr_code_scanner.dart';
import 'package:thesis/screens/volunteer.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool logged = true;
  bool volunteer = false;
  @override
  Widget build(BuildContext context) {
    if (logged)
      return Homepage(openQRCodeScanner, openEmergencyNumbers, setLogged);
    else if (volunteer)
      return Volunteer(setVolunteer);
    else
      return Login(
          openQRCodeScanner, openEmergencyNumbers, setLogged, setVolunteer);
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

  setLogged() {
    setState(() {
      logged = !logged;
    });
  }

  setVolunteer() {
    setState(() {
      volunteer = !volunteer;
    });
  }
}
