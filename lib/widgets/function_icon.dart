import 'package:flutter/material.dart';

class FunctionIcon extends StatelessWidget {
  final Icon icon;
  const FunctionIcon({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: icon,
    );
  }
}
