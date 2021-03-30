import 'package:flutter/material.dart';
import 'package:thesis/screens/homepage.dart';
import 'package:thesis/screens/login.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool logged = true;
  @override
  Widget build(BuildContext context) {
    return logged ? Homepage() : Login();
  }
}
