import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NumbersCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  final String number;
  final String email;
  const NumbersCard(
      this.icon, this.title, this.subtitle, this.number, this.email);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: icon,
          ),
          Divider(),
          /* ListTile(
            title: Text("Contatti"),
          ), */
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              number,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: _launchPhone,
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text(
              email,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: _launchEmail,
          ),
        ],
      ),
    );
  }

  _launchPhone() async {
    String url = 'tel:' + number;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }

  _launchEmail() async {
    String url = 'mailto:' + email;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch';
  }
}
