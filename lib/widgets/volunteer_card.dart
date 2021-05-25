import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/function_button.dart';

class VolunteerCard extends StatefulWidget {
  final Citizen patient;
  final int index;
  final getDate;
  final setDate;
  final removePatient;
  const VolunteerCard(
      this.patient, this.index, this.getDate, this.setDate, this.removePatient);

  @override
  _VolunteerCardState createState() => _VolunteerCardState();
}

class _VolunteerCardState extends State<VolunteerCard> {
  String currentDate;

  @override
  void initState() {
    currentDate = widget.patient.data.keys.last;
    super.initState();
  }

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
                  icon: Icon(Icons.calendar_today),
                  initialValue: currentDate,
                  itemBuilder: (BuildContext context) {
                    return widget.patient.data.keys.map((element) {
                      return PopupMenuItem(
                        value: element,
                        child: Text(element),
                      );
                    }).toList();
                  },
                  onSelected: (value) {
                    setState(() {
                      currentDate = value;
                      widget.setDate(widget.index, value);
                    });
                  },
                ),
                IconButton(icon: Icon(Icons.close), onPressed: remove),
              ],
            ),
            title: Text(widget.patient.fullName),
            subtitle: Text(widget.patient.cf),
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
                  "Ultimo aggiornamento: ${widget.patient.data.keys.last}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  printBadge() async {
    await PDFHandler(
            citizen: widget.patient,
            timestampCitizen: widget.patient.data[currentDate])
        .printBadge();
  }

  printCIS() async {
    await PDFHandler(
            citizen: widget.patient,
            timestampCitizen: widget.patient.data[currentDate])
        .printCIS();
  }

  printBracelet() async {
    await PDFHandler(timestampCitizen: widget.patient.data[currentDate])
        .printBracelet();
  }

  remove() {
    widget.removePatient(widget.patient.cf);
  }
}
