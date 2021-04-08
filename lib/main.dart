import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thesis/screens/wrapper.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Initialization(),
    );
  }
}

class Initialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error");
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Wrapper();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
