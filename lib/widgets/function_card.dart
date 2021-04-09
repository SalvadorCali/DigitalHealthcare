import 'package:flutter/material.dart';
import 'package:thesis/widgets/function_button.dart';

class FunctionCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  final openFunction;
  final downloadFunction;
  final shareFunction;
  const FunctionCard(this.icon, this.title, this.description, this.openFunction,
      this.downloadFunction, this.shareFunction);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: icon,
            title: Text(title),
            subtitle: Text('Subtitle prova'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                FunctionButton(
                    openFunction, Icon(Icons.picture_as_pdf), "Apri"),
                FunctionButton(downloadFunction, Icon(Icons.save), "Salva"),
                FunctionButton(shareFunction, Icon(Icons.share), "Condividi"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
