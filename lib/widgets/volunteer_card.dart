import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/patient.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/function_button.dart';

class VolunteerCard extends StatelessWidget {
  final Patient patient;
  final removePatient;
  const VolunteerCard(this.patient, this.removePatient);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton(
                  icon: Icon(Icons.menu),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(child: Text('Item A')),
                    const PopupMenuItem(child: Text('Item B')),
                  ],
                ),
                IconButton(icon: Icon(Icons.close), onPressed: remove),
              ],
            ),
            title: Text(patient.name),
            subtitle: Text('CLCNDR96D19A940K'),
          ),
          Divider(),
          ListTile(
            leading: icons[1],
            title: Text(functionalities[1]),
            trailing: FunctionButton(printBadge, Icon(Icons.print), "Stampa"),
          ),
          ListTile(
            leading: icons[2],
            title: Text(functionalities[2]),
            trailing: FunctionButton(printCIS, Icon(Icons.print), "Stampa"),
          ),
          ListTile(
            leading: icons[3],
            title: Text(functionalities[3]),
            trailing:
                FunctionButton(printBracelet, Icon(Icons.print), "Stampa"),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ultimo aggiornamento: 21/04/21",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          /* ListTile(
            dense: true,
            subtitle: Text("Ultimo aggiornamento: 21/04/21"),
            minVerticalPadding: 0,
          ), */
        ],
      ),
    );
  }

  printBadge() async {
    await PDFHandler(
            qrData: patient.getLifeSavingInformation(), patient: patient)
        .printBadge();
  }

  printCIS() async {
    await PDFHandler(
            qrData: patient.getLifeSavingInformation(), patient: patient)
        .printCIS();
  }

  printBracelet() async {
    await PDFHandler(
            qrData: patient.getLifeSavingInformation(), patient: patient)
        .printBracelet();
  }

  remove() {
    removePatient(patient.name);
  }
}
