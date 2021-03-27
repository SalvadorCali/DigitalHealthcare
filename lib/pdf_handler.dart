import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PDFHandler {
  final String data = "dati";
  final String bracelet = "braccialetto";
  final String cis = "cis";
  final String sheet = "scheda";

  final pdf = Document();

  //dati
  openData() async {
    _createData();
    _savePDF(data);
    _openPDF(data);
  }

  _createData() {}

  //braccialetto
  openBracelet() async {
    await _createBracelet();
    await _savePDF(bracelet);
    await _openPDF(bracelet);
  }

  _createBracelet() async {
    final logo =
        (await rootBundle.load('assets/logos/112.jpg')).buffer.asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return Row(children: [
            _braceletLogo(logo),
            _braceletLogo(logo),
            _braceletLogo(logo),
            _braceletLogo(logo),
            _braceletLogo(logo),
            _braceletLogo(logo),
          ]);
        }));
  }

  Container _braceletLogo(image) {
    return Container(
      width: PdfPageFormat.a4.width / 6,
      height: PdfPageFormat.a4.height / 10,
      child: Image(MemoryImage(image), fit: BoxFit.cover),
    );
  }

  //cis
  openCIS() async {
    _createCIS();
    _savePDF(cis);
    _openPDF(cis);
  }

  _createCIS() async {
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return GridView(
              crossAxisCount: 2,
              childAspectRatio:
                  (PdfPageFormat.a4.height / 2) / (PdfPageFormat.a4.width / 2),
              children: [
                _blockOne(),
                _blockTwo(),
                _blockThree(),
                _blockFour(),
              ]);
        }));
  }

  Container _blockOne() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
              color: PdfColors.black,
              height: PdfPageFormat.a4.height / 10,
              child: Row(children: [Text("Prova"), Text("Prova")])),
        ]));
  }

  Container _blockTwo() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        color: PdfColors.black);
  }

  Container _blockThree() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        color: PdfColors.black);
  }

  Container _blockFour() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        color: PdfColors.amber);
  }

  //scheda
  openSheet() async {
    _createSheet();
    _savePDF(sheet);
    _openPDF(sheet);
  }

  _createSheet() {}

  //general
  Future _savePDF(String name) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/$name.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  _openPDF(String name) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/$name.pdf");
    await OpenFile.open(file.path, type: "application/pdf");
  }
}
