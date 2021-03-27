import 'package:flutter/material.dart';
import 'package:thesis/widgets/function_button.dart';

class FunctionCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  const FunctionCard(this.icon, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: icon,
            title: Text(title),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
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
                    printSomething, Icon(Icons.picture_as_pdf), "Apri"),
                FunctionButton(printSomething, Icon(Icons.save), "Salva"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  printSomething() {
    print("Something");
  }
}
