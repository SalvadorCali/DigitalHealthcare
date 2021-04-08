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
import 'package:thesis/model/patient.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFHandler {
  //A4: 297mm x 210mm
  final String data = "dati";
  final String bracelet = "braccialetto";
  final String cis = "cis";
  final String badge = "badge";

  final pdf = Document();
  final Patient patient;
  final String qrData;

  PDFHandler({this.patient, this.qrData});

  //dati
  openData() async {
    await _createData();
    await _savePDF(data);
    await _openPDF(data);
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
                ..._createPSS(),
              ]);
        }));
  }

  List<Widget> _createPSS() {
    List<Widget> widgets = [];
    patient.toMapIta().forEach((key, value) {
      widgets.add(Text("$key: $value"));
    });
    return widgets;
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
    //21.7mm x 114.5mm
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
    final polimi = (await rootBundle.load('assets/logos/polimi2.png'))
        .buffer
        .asUint8List();
    final areu =
        (await rootBundle.load('assets/logos/areu2.jpg')).buffer.asUint8List();
    final centodiciotto =
        (await rootBundle.load('assets/logos/118.jpg')).buffer.asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return Row(children: [
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: PdfColors.black)),
                child: Row(children: [
                  _braceletLogo(municipioTre),
                  _braceletLogo(comuneMilano),
                  _braceletLogo(mvi),
                  _braceletLogo(polimi),
                  Container(
                    width: (PdfPageFormat.a4.width / 1.83) / 7,
                    height: PdfPageFormat.a4.height / 13.68,
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: BarcodeWidget(
                          data: qrData,
                          width: (PdfPageFormat.a4.width / 1.83) / 7,
                          height: PdfPageFormat.a4.height / 13.68,
                          barcode: Barcode.qrCode(),
                        )),
                  ),
                  _braceletLogo(areu),
                  _braceletLogo(centodiciotto),
                ])),
          ]);
        }));
  }

  Container _braceletLogo(image) {
    return Container(
        width: (PdfPageFormat.a4.width / 1.83) / 7,
        height: PdfPageFormat.a4.height / 13.68,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Image(MemoryImage(image), fit: BoxFit.fitWidth),
        ));
  }

  //badge
  openBadge() async {
    await _createBadge();
    await _savePDF(badge);
    await _openPDF(badge);
  }

  downloadBadge() async {
    await _createBadge();
    await _downloadPDF(badge);
  }

  _createBadge() async {
    final mvi =
        (await rootBundle.load('assets/logos/mvi.png')).buffer.asUint8List();
    final ice =
        (await rootBundle.load('assets/logos/ice.png')).buffer.asUint8List();
    final profile = (await rootBundle.load('assets/images/profile.jpeg'))
        .buffer
        .asUint8List();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(0),
        build: (Context context) {
          return _blockFour(mvi, ice, profile);
        }));
  }

  //cis
  openCIS() async {
    await _createCIS();
    await _savePDF(cis);
    await _openPDF(cis);
  }

  downloadCIS() async {
    await _createCIS();
    await _downloadPDF(cis);
  }

  _createCIS() async {
    final centodiciotto =
        (await rootBundle.load('assets/logos/118.jpg')).buffer.asUint8List();
    final centododici =
        (await rootBundle.load('assets/logos/112.png')).buffer.asUint8List();
    final comuneMilano =
        (await rootBundle.load('assets/logos/comune_milano2.png'))
            .buffer
            .asUint8List();
    final mvi =
        (await rootBundle.load('assets/logos/mvi.png')).buffer.asUint8List();
    final areu =
        (await rootBundle.load('assets/logos/areu2.jpg')).buffer.asUint8List();
    final simeu =
        (await rootBundle.load('assets/logos/simeu.png')).buffer.asUint8List();
    final omceo =
        (await rootBundle.load('assets/logos/omceo.jpg')).buffer.asUint8List();
    final ice =
        (await rootBundle.load('assets/logos/ice.png')).buffer.asUint8List();
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
                _blockTwo(comuneMilano, mvi, areu, simeu, omceo),
                _blockThree(),
                _blockFour(mvi, ice, profile),
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
                        width: (PdfPageFormat.a4.width / 2) / 3,
                        child: Image(MemoryImage(centodiciotto),
                            fit: BoxFit.fitWidth)),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 3,
                        child: Image(MemoryImage(centododici),
                            fit: BoxFit.fitWidth)),
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
                        RichText(
                          text: TextSpan(
                              text: 'la CIS è fornita ',
                              style: TextStyle(fontWeight: FontWeight.normal),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'gratuitamente',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: " all'utilizzatore e ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  'senza alcuna garanzia esplicita o implicita.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ]),
                              ]),
                        ),
                        Text(
                            "-la responsabilità della correttezza e validità delle informazioni/dati non può essere ascritta all'autore della SAPP"),
                        Text(
                            "-le informazioni ed i dati inseriti vengono memorizzati in forma anonima e per meri fini statistici"),
                        Text(
                            "-è cura dell'interessato ripresentarsi ogniqualvolta ci sia una variazione dei dati e comunque ogni SEI MESI",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]))),
          Container(
              height: PdfPageFormat.a4.height / 10,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("*SAPP (Social APPlication)"),
                        Text("www.iltelefoninoiltuosalvavita.org"),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Empowered by G7 Soluzioni Informatiche")
                            ]),
                      ])))
        ]));
  }

  Container _blockTwo(comuneMilano, mvi, areu, simeu, omceo) {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: PdfColors.black)),
            height: PdfPageFormat.a4.height / 10,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: (PdfPageFormat.a4.width / 2) / 2,
                          child: Image(MemoryImage(comuneMilano),
                              fit: BoxFit.fitWidth)),
                      Container(
                          width: (PdfPageFormat.a4.width / 2) / 4,
                          child: Image(MemoryImage(mvi), fit: BoxFit.fitWidth)),
                    ])),
          ),
          Container(
              height: (PdfPageFormat.a4.height / 10) * 3,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("PROGETTO",
                            style: TextStyle(color: PdfColors.red)),
                        Text("CITTADINI",
                            style: TextStyle(color: PdfColors.red)),
                        Text("Più coinvolti & più sicuri".toUpperCase(),
                            style: TextStyle(color: PdfColors.red)),
                        SizedBox(height: 20),
                        Text("C.I.S.",
                            style:
                                TextStyle(fontSize: 35, color: PdfColors.red)),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: 'C',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: PdfColors.red),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "arta d'",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: PdfColors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'I',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: PdfColors.red),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'dentità ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: PdfColors.red),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'S',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: PdfColors.red),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'alvavita',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: PdfColors
                                                                  .red),
                                                        ),
                                                      ]),
                                                ]),
                                          ]),
                                    ]),
                              ]),
                        ),
                      ]))),
          Container(
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 3,
                        child: Image(MemoryImage(areu), fit: BoxFit.fitWidth)),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 3,
                        child: Image(MemoryImage(simeu), fit: BoxFit.fitWidth)),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 4,
                        child: Image(MemoryImage(omceo), fit: BoxFit.fitWidth)),
                  ]))
        ]));
  }

  Container _blockThree() {
    return Container(
        width: PdfPageFormat.a4.width / 2,
        height: PdfPageFormat.a4.height / 2,
        child: Column(children: [
          Container(
            width: PdfPageFormat.a4.width / 2,
            height: (PdfPageFormat.a4.height / 10) * 4,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("DATI SALVAVITA",
                    style: TextStyle(color: PdfColors.red)),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: PdfPageFormat.a4.width / 4 - 8,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [..._createKeys()]),
                        ),
                        Container(
                          width: PdfPageFormat.a4.width / 4 - 8,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [..._createValues()]),
                        ),
                      ])),
            ]),
          ),
          Container(
              width: PdfPageFormat.a4.width / 2,
              height: PdfPageFormat.a4.height / 10,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Documenti e codici utilizzati:".toUpperCase(),
                            style: TextStyle(fontSize: 8)),
                        Text(
                            "C.I.N° AB123456, Emesso da: Milano, il: 31/12/2020",
                            style: TextStyle(fontSize: 8)),
                        Text("CRS N° 321654987; C.F.:MRRRSS54XABF123",
                            style: TextStyle(fontSize: 8)),
                        Text("Codici ATS: Assistito: ; Esenzioni: ",
                            style: TextStyle(fontSize: 8)),
                        Text(
                            "Informazioni mediche Salvavita condivide son SIMEU a novembre 2015",
                            style: TextStyle(fontSize: 8)),
                        SizedBox(height: 10),
                        Text("cdm10021501903", style: TextStyle(fontSize: 8)),
                      ])))
        ]));
  }

  Container _blockFour(mvi, ice, profile) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: PdfColors.black)),
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
                        width: (PdfPageFormat.a4.width / 2) / 4,
                        child: Image(MemoryImage(mvi), fit: BoxFit.fitWidth)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'I',
                                style: TextStyle(
                                    fontSize: 18, color: PdfColors.red),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'N',
                                      style: TextStyle(
                                          fontSize: 18, color: PdfColors.white),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' C',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: PdfColors.red),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'ASO',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: PdfColors.white),
                                              ),
                                            ]),
                                      ]),
                                ]),
                          ),
                          Text(
                            "di",
                            style:
                                TextStyle(fontSize: 18, color: PdfColors.white),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'E',
                                style: TextStyle(
                                    fontSize: 18, color: PdfColors.red),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'MERGENZA',
                                    style: TextStyle(
                                        fontSize: 18, color: PdfColors.white),
                                  ),
                                ]),
                          ),
                        ]),
                    Container(
                        width: (PdfPageFormat.a4.width / 2) / 4,
                        child: Image(MemoryImage(ice), fit: BoxFit.fitWidth)),
                  ])),
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: PdfColors.black)),
              height: PdfPageFormat.a4.height / 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ICE1: 39239233392",
                                  style: TextStyle(
                                      fontSize: 18, color: PdfColors.orange)),
                              Text("ICE2: 39239233392",
                                  style: TextStyle(
                                      fontSize: 18, color: PdfColors.orange))
                            ])),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                          height: (PdfPageFormat.a4.height / 10),
                          width: (PdfPageFormat.a4.width / 10),
                          child: Image(MemoryImage(profile),
                              fit: BoxFit.fitWidth)),
                    )
                  ])),
          Container(
              height: (PdfPageFormat.a4.height / 10) * 3,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                BarcodeWidget(
                  data: qrData,
                  width: (PdfPageFormat.a4.width / 10) * 2,
                  height: (PdfPageFormat.a4.height / 10) * 2,
                  barcode: Barcode.qrCode(),
                )
              ])),
        ]));
  }

  List<Widget> _createKeys() {
    List<Widget> widgets = [];
    patient.toMapIta().forEach((key, value) {
      widgets.add(Text("$key", style: TextStyle(fontWeight: FontWeight.bold)));
    });
    return widgets;
  }

  List<Widget> _createValues() {
    List<Widget> widgets = [];
    patient.toMapIta().forEach((key, value) {
      widgets.add(Text("$value"));
    });
    return widgets;
  }

  //general
  Future _savePDF(String name) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/$name.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  _openPDF(String name) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentDirectory.path;
      File file = File("$documentPath/$name.pdf");
      await OpenFile.open(file.path, type: "application/pdf");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  openOnlinePDF(String name) async {
    await canLaunch(name) ? await launch(name) : throw 'Could not launch';
  }

  _downloadPDF(String name) async {
    //cancellare se già esiste il file
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    String downloadPath = downloadsDirectory.path;
    File file = File("$downloadPath/$name.pdf");
    file.writeAsBytesSync(await pdf.save());
    Fluttertoast.showToast(msg: "Downloaded!");
  }
}
