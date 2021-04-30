import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/model/end_user.dart';
import 'package:thesis/model/patient.dart';
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
    //user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() {
          logged = false;
        });
      } else {
        setState(() {
          logged = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (logged) {
      return FutureBuilder<EndUser>(
          future: DatabaseService().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              EndUser endUser = snapshot.data;
              if (snapshot.data.isUser) {
                return FutureBuilder<Patient>(
                    future: DatabaseService().getPatient(endUser.tin),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Patient patient = snapshot.data;
                        return Homepage(patient, openQRCodeScanner,
                            openEmergencyNumbersLogged, logout);
                      } else {
                        return Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                      }
                    });
              } else {
                return FutureBuilder<List<Patient>>(
                    future: DatabaseService().getPatientsList(endUser.tin),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Patient> patients = snapshot.data;
                        DatabaseService().populatePatientsData(patients);
                        return Volunteer(patients, logout);
                      } else {
                        return Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                      }
                    });
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
