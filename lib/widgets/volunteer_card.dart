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
            trailing: IconButton(icon: Icon(Icons.close), onPressed: remove),
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
