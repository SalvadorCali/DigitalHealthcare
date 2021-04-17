import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/widgets/function_icon.dart';

class FunctionCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  final openFunction;
  final downloadFunction;
  final printFunction;
  final shareFunction;
  const FunctionCard(this.icon, this.title, this.description, this.openFunction,
      this.downloadFunction, this.printFunction, this.shareFunction);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
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
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: kIsWeb
                    ? <Widget>[
                        FunctionIcon(
                            openFunction, Icon(Icons.picture_as_pdf), "Apri"),
                        FunctionIcon(
                            downloadFunction, Icon(Icons.save), "Salva"),
                        FunctionIcon(
                            printFunction, Icon(Icons.print), "Stampa"),
                      ]
                    : <Widget>[
                        FunctionIcon(
                            openFunction, Icon(Icons.picture_as_pdf), "Apri"),
                        FunctionIcon(
                            downloadFunction, Icon(Icons.save), "Salva"),
                        FunctionIcon(
                            printFunction, Icon(Icons.print), "Stampa"),
                        FunctionIcon(
                            shareFunction, Icon(Icons.share), "Condividi"),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
