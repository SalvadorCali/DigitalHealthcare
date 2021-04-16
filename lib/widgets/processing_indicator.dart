import 'package:flutter/material.dart';

class ProcessingIndicator extends StatelessWidget {
  final String text;
  ProcessingIndicator(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator(), Text(text)],
    );
  }
}
