import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PDFHandler {
  final pdf = Document();

  generatePDF() async {
    await _createPDF();
    await _savePDF();
    await _openPDF();
  }

  _createPDF() async {
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(32),
        build: (Context context) {
          return <Widget>[
            Header(level: 0, child: Text("Easy approach document")),
            Paragraph(text: "Lorem ipsum dolor sit amet."),
            Paragraph(text: "Lorem ipsum dolor sit amet."),
            Header(level: 1, child: Text("Prova")),
            Paragraph(text: "Lorem ipsum dolor sit amet.")
          ];
        }));
  }

  Future _savePDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  _openPDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    await OpenFile.open(file.path, type: "application/pdf");
  }
}
