import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerCard extends StatefulWidget {
  final Citizen citizen;
  final int index;
  final getDate;
  final setDate;
  final removePatient;
  const VolunteerCard(
      this.citizen, this.index, this.getDate, this.setDate, this.removePatient);

  @override
  _VolunteerCardState createState() => _VolunteerCardState();
}

class _VolunteerCardState extends State<VolunteerCard> {
  String currentDate;

  @override
  void initState() {
    currentDate = widget.citizen.data.keys.last;
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
                    return widget.citizen.data.keys.map((element) {
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
            title: Text(widget.citizen.fullName),
            subtitle: Text(widget.citizen.cf),
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
            trailing: FunctionButton(printSheet, Icon(Icons.print), "Stampa"),
          ),
          ListTile(
            leading: icons[4],
            title: Text(functionalities[4]),
            trailing:
                FunctionButton(printBracelet, Icon(Icons.print), "Stampa"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              widget.citizen.data[currentDate].telefono,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: _launchPhone,
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text(
              widget.citizen.data[currentDate].email,
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
                  "Ultimo aggiornamento: ${widget.citizen.data.keys.last}",
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
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
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
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .printCIS()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  printBracelet() async {
    _showLoadingDialog();
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .printBracelet()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  printSheet() async {
    _showLoadingDialog();
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .printSheet()
          .whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  _launchPhone() async {
    String url = 'tel:' + widget.citizen.data[currentDate].telefono;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }

  _launchEmail() async {
    String url = 'mailto:' + widget.citizen.data[currentDate].email;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }

  remove() {
    widget.removePatient(widget.citizen.cf);
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
                Center(child: Text('Generazione documento in corso...')),
              ],
            ),
          ),
        );
      },
    );
  }
}
