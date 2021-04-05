import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thesis/constants.dart';

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

  downloadData() async {
    await _createData();
    await _downloadPDF(data);
  }

  _createData() {
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profilo sanitario sintetico".toUpperCase()),
                Text(aCapo),
                Text("Nome: Andrea Calici")
              ]);
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
    final municipioTre =
        (await rootBundle.load('assets/logos/municipio_tre.png'))
            .buffer
            .asUint8List();
    final comuneMilano =
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
            _braceletLogo(municipioTre),
            _braceletLogo(comuneMilano),
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
    await _createBadge();
    _savePDF(badge);
    _openPDF(badge);
  }

  downloadBadge() async {
    await _createBadge();
    await _downloadPDF(badge);
  }

  _createBadge() async {
    final mvi =
        (await rootBundle.load('assets/logos/mvi.png')).buffer.asUint8List();
    final profile = (await rootBundle.load('assets/images/profile.jpeg'))
        .buffer
        .asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return _blockFour(mvi, profile);
        }));
  }

  //cis
  openCIS() async {
    await _createCIS();
    _savePDF(cis);
    _openPDF(cis);
  }

  downloadCIS() async {
    await _createCIS();
    await _downloadPDF(cis);
  }

  _createCIS() async {
    final centodiciotto =
        (await rootBundle.load('assets/logos/118.jpg')).buffer.asUint8List();
    final centododici =
        (await rootBundle.load('assets/logos/112.jpg')).buffer.asUint8List();
    final comuneMilano =
        (await rootBundle.load('assets/logos/comune_milano.png'))
            .buffer
            .asUint8List();
    final mvi =
        (await rootBundle.load('assets/logos/mvi.png')).buffer.asUint8List();
    final profile = (await rootBundle.load('assets/images/profile.jpeg'))
        .buffer
        .asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return GridView(
              crossAxisCount: 2,
              childAspectRatio:
                  (PdfPageFormat.a4.height / 2) / (PdfPageFormat.a4.width / 2),
              children: [
                _blockOne(centodiciotto, centododici),
                _blockTwo(comuneMilano, mvi),
                _blockThree(),
                _blockFour(mvi, profile),
              ]);
        }));
  }

  Container _blockOne(centodiciotto, centododici) {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 5,
                        child: Image(MemoryImage(centodiciotto),
                            fit: BoxFit.cover)),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 5,
                        child:
                            Image(MemoryImage(centododici), fit: BoxFit.cover)),
                  ])),
          Container(
              height: (PdfPageFormat.a4.height / 10) * 3,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "-la CIS contiene tutte le informazioni/dati che sono stati inseriti nella SAPP*"),
                        Text(
                            "-la CIS è fornita gratuitamente all'utilizzatore e senza alcuna garanzia esplicita o implicita"),
                        Text(
                            "-la responsabilità della correttezza e validità delle informazioni/dati non può essere ascritta all'autore della SAPP"),
                        Text(
                            "-le informazioni ed i dati inseriti vengono memorizzati in forma anonima e per meri fini statistici"),
                        Text(
                            "-è cura dell'interessato ripresentarsi ogniqualvolta ci sia una variazione dei dati e comunque ogni SEI MESI"),
                      ]))),
          Container(
              height: PdfPageFormat.a4.height / 10,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("*SAPP (Social APPlication)"),
                Text("www.iltelefoninoiltuosalvavita.org"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Empowered by G7 Soluzioni Informatiche")]),
              ]))
        ]));
  }

  Container _blockTwo(comuneMilano, mvi) {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 5,
                        child: Image(MemoryImage(comuneMilano),
                            fit: BoxFit.cover)),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 5,
                        child: Image(MemoryImage(mvi), fit: BoxFit.cover)),
                  ])),
          Container(
              height: (PdfPageFormat.a4.height / 10) * 3,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Progetto".toUpperCase()),
                        Text("Cittadini".toUpperCase()),
                        Text("Più coinvolti & più sicuri".toUpperCase()),
                        Text("C.I.S.".toUpperCase()),
                        Text("Carta d'Identità Salvavita"),
                      ]))),
          Container(
              height: PdfPageFormat.a4.height / 10,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("*SAPP (Social APPlication)"),
                Text("www.iltelefoninoiltuosalvavita.org"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Empowered by G7 Soluzioni Informatiche")]),
              ]))
        ]));
  }

  Container _blockThree() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
            height: (PdfPageFormat.a4.height / 10) * 4,
          ),
          Container(
              height: PdfPageFormat.a4.height / 10,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Documenti e codici utilizzati:".toUpperCase()),
                    Text("C.I.N° AB123456, Emesso da: Milano, il: 31/12/2020"),
                    Text("CRS N° 321654987; C.F.:MRRRSS54XABF123"),
                    Text("Codici ATS: Assistito: ; Esenzioni: "),
                    Text(
                        "Informazioni mediche Salvavita condivide son SIMEU a novembre 2015"),
                    Text("cdm10021501903"),
                  ]))
        ]));
  }

  Container _blockFour(mvi, profile) {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
              color: PdfColors.black,
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 6,
                        child: Image(MemoryImage(mvi), fit: BoxFit.cover)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("In caso".toUpperCase()),
                          Text("di"),
                          Text("Emergenza".toUpperCase())
                        ]),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 6,
                        child: Image(MemoryImage(mvi), fit: BoxFit.cover)),
                  ])),
          Container(
              color: PdfColors.white,
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Text("ICE1: 3927713177"),
                      Text("ICE2: 3927713177")
                    ]),
                    Container(
                        height: (PdfPageFormat.a4.height / 10),
                        width: (PdfPageFormat.a4.width / 10),
                        child: Image(MemoryImage(profile), fit: BoxFit.cover)),
                  ])),
          Container(
              height: (PdfPageFormat.a4.height / 10) * 3,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BarcodeWidget(
                  data: qrData,
                  width: (PdfPageFormat.a4.width / 10) * 2,
                  height: (PdfPageFormat.a4.height / 10) * 2,
                  barcode: Barcode.qrCode(),
                )
              ])),
        ]));
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
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    Directory prova = await getExternalStorageDirectory();
    String downloadPath = downloadsDirectory.path;
    print("Download" + downloadPath);
    print("Path" + prova.path);
    File file = File("$downloadPath/$name.pdf");
    file.writeAsBytesSync(await pdf.save());
    Fluttertoast.showToast(msg: "Downloaded!");
  }
}
