import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FunctionButton extends StatelessWidget {
  final onPressed;
  final Icon icon;
  final String label;
  const FunctionButton({Key key, this.onPressed, this.icon, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed, icon: icon, label: Text(label));
  }
}
