import 'package:flutter/material.dart';
import 'package:thesis/screens/wrapper.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Wrapper(),
    );
  }
}
