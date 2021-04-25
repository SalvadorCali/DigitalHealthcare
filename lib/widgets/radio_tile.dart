import 'package:flutter/material.dart';

class RadioTile extends StatelessWidget {
  final String title;
  final String groupValue;
  final changeFunction;
  RadioTile(this.title, this.groupValue, this.changeFunction);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: title,
        groupValue: groupValue,
        onChanged: (String value) {
          changeFunction(value);
        },
      ),
    );
  }
}
