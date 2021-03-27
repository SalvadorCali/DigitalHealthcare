import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PDFHandler {
  final String data = "dati";
  final String bracelet = "braccialetto";
  final String cis = "cis";
  final String badge = "badge";

  final pdf = Document();
  final String qrData;

  PDFHandler(this.qrData);

  //dati
  openData() async {
    _createData();
    _savePDF(data);
    _openPDF(data);
  }

  _createData() {
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Row(children: [Text("Profilo sanitario sintetico")]);
        }));
  }

  //braccialetto
  openBracelet() async {
    await _createBracelet();
    await _savePDF(bracelet);
    await _openPDF(bracelet);
  }

  downloadBracelet() async {
    await _createBracelet();
    await _downloadPDF(bracelet);
  }

  _createBracelet() async {
    final municipio_tre =
        (await rootBundle.load('assets/logos/municipio_tre.png'))
            .buffer
            .asUint8List();
    final comune_milano =
        (await rootBundle.load('assets/logos/comune_milano.png'))
            .buffer
            .asUint8List();
    final mvi =
        (await rootBundle.load('assets/logos/mvi.png')).buffer.asUint8List();
    final polimi =
        (await rootBundle.load('assets/logos/polimi.png')).buffer.asUint8List();
    final areu =
        (await rootBundle.load('assets/logos/areu2.jpg')).buffer.asUint8List();
    final centodiciotto =
        (await rootBundle.load('assets/logos/118.jpg')).buffer.asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return Row(children: [
            _braceletLogo(municipio_tre),
            _braceletLogo(comune_milano),
            _braceletLogo(mvi),
            _braceletLogo(polimi),
            Container(
                width: PdfPageFormat.a4.width / 7,
                height: PdfPageFormat.a4.height / 10,
                child: BarcodeWidget(
                  data: qrData,
                  width: PdfPageFormat.a4.width / 7 - 10,
                  height: PdfPageFormat.a4.height / 10 - 10,
                  barcode: Barcode.qrCode(),
                )),
            _braceletLogo(areu),
            _braceletLogo(centodiciotto),
          ]);
        }));
  }

  Container _braceletLogo(image) {
    return Container(
      width: PdfPageFormat.a4.width / 7,
      height: PdfPageFormat.a4.height / 10,
      child: Image(MemoryImage(image), fit: BoxFit.cover),
    );
  }

  //badge
  openBadge() async {
    _createBadge();
    _savePDF(badge);
    _openPDF(badge);
  }

  _createBadge() {}

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

  _downloadPDF(String name) async {
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    String downloadPath = downloadsDirectory.path;
    File file = File("$downloadPath/$name.pdf");
    file.writeAsBytesSync(await pdf.save());
    Fluttertoast.showToast(msg: "Downloaded!");
  }
}
