import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/function_button.dart';

class CovidTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final String document;
  const CovidTile(this.title, this.date, this.document);

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate(date);
    return Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          title: Text(title),
          subtitle: Text(formattedDate),
          trailing:
              FunctionButton(_openDocument, Icon(Icons.picture_as_pdf), "Apri"),
        ));
  }

  _openDocument() {
    PDFHandler().openOnlinePDF(document);
  }
}
