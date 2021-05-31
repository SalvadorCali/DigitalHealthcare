import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              widget.patient.data[currentDate].telefono,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: _launchPhone,
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text(
              widget.patient.data[currentDate].email,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: _launchEmail,
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
    _showLoadingDialog();
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.patient,
              timestampCitizen: widget.patient.data[currentDate])
          .printBadge()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  printCIS() async {
    _showLoadingDialog();
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.patient,
              timestampCitizen: widget.patient.data[currentDate])
          .printCIS()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  printBracelet() async {
    _showLoadingDialog();
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.patient.data[currentDate])
          .printBracelet()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  _launchPhone() async {
    String url = 'tel:' + widget.patient.data[currentDate].telefono;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }

  _launchEmail() async {
    String url = 'mailto:' + widget.patient.data[currentDate].email;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }

  remove() {
    widget.removePatient(widget.patient.cf);
  }

  Future<void> _showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.upload_file),
                ),
                //Image.asset("assets/images/loading.gif"),
                Center(child: Text('Generazione documento in corso...')),
              ],
            ),
          ),
        );
      },
    );
  }
}
