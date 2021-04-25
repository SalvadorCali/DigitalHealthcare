import 'package:flutter/material.dart';
import 'package:thesis/widgets/radio_tile.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List<String> prova = ["A", "B", "C"];
  String choice = "A";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Archivio"),
        automaticallyImplyLeading: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [
        ListTile(
          title: Text("Scegli una data:"),
        ),
        RadioTile(prova[0], choice, changeFunction),
        RadioTile(prova[1], choice, changeFunction),
        RadioTile(prova[2], choice, changeFunction),
        /* ListTile(
          title: Text(prova[0]),
          leading: Radio<String>(
            value: prova[0],
            groupValue: choice,
            onChanged: (String value) {
              setState(() {
                choice = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(prova[1]),
          leading: Radio<String>(
            value: prova[1],
            groupValue: choice,
            onChanged: (String value) {
              setState(() {
                choice = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(prova[2]),
          leading: Radio<String>(
            value: prova[2],
            groupValue: choice,
            onChanged: (String value) {
              setState(() {
                choice = value;
              });
            },
          ),
        ) */
      ],
    );
  }

  changeFunction(String value) {
    setState(() {
      choice = value;
    });
  }
}
