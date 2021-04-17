import 'package:flutter/material.dart';

class FunctionIcon extends StatelessWidget {
  final onPressed;
  final Icon icon;
  final String tooltip;
  const FunctionIcon(this.onPressed, this.icon, this.tooltip);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Theme.of(context).primaryColor,
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
