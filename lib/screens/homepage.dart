import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/patient.dart';
import 'package:thesis/services/database_service.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/services/qr_code_handler.dart';
import 'package:thesis/widgets/appbar_button.dart';
import 'package:thesis/widgets/covid_tile.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:thesis/widgets/function_card.dart';
import 'package:thesis/widgets/processing_indicator.dart';

class Homepage extends StatefulWidget {
  final openQRCodeScanner;
  final openEmergencyNumbers;
  final changeScreen;
  Homepage(
      this.openQRCodeScanner, this.openEmergencyNumbers, this.changeScreen);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // 1) ottengo dati da Firebase
  // 2) creo Patient
  // 3) passo Patient per usarne dati

  final Patient patient = createPatient();
  String qrCodeData;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    _initializePatient();
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Homepage"),
            actions: [
              kIsWeb
                  ? SizedBox.shrink()
                  : AppBarButton(Icon(Icons.contact_phone_outlined),
                      widget.openEmergencyNumbers),
              kIsWeb
                  ? SizedBox.shrink()
                  : AppBarButton(
                      Icon(Icons.qr_code_scanner), widget.openQRCodeScanner),
              AppBarButton(Icon(Icons.logout), widget.changeScreen),
            ],
            bottom: TabBar(
              tabs: kIsWeb
                  ? [
                      Tab(icon: Icon(Icons.qr_code), text: "Codice QR"),
                      Tab(icon: Icon(Icons.info), text: "Informazioni"),
                      Tab(icon: Icon(Icons.coronavirus), text: "Covid19"),
                    ]
                  : [
                      Tab(icon: Icon(Icons.qr_code)),
                      Tab(icon: Icon(Icons.info)),
                      Tab(icon: Icon(Icons.coronavirus)),
                    ],
            ),
          ),
          body: FutureBuilder<String>(
              future: DatabaseService().getProva(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return TabBarView(children: [
                    _qrCodeScreen(),
                    _functionalitiesScreen(),
                    _covidScreen()
                  ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  _initializePatient() {
    setState(() {
      qrCodeData = patient.getLifeSavingInformation();
    });
  }

  Widget _qrCodeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QRCodeHandler().generateQRCode(qrCodeData),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FunctionButton(openQRCode, Icon(Icons.image), "Apri"),
              FunctionButton(saveQRCodeToGallery, Icon(Icons.save), "Salva"),
              FunctionButton(printQRCode, Icon(Icons.print), "Stampa"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _functionalitiesScreen() {
    return processing
        ? ProcessingIndicator("Prova")
        : kIsWeb
            ? Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FunctionCard(
                            icons[0],
                            functionalities[0],
                            descriptions[0],
                            openData,
                            downloadData,
                            printData,
                            shareData),
                      ),
                      Flexible(
                        child: FunctionCard(
                            icons[1],
                            functionalities[1],
                            descriptions[1],
                            openBadge,
                            downloadBadge,
                            printBadge,
                            shareBadge),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: FunctionCard(
                            icons[2],
                            functionalities[2],
                            descriptions[2],
                            openCIS,
                            downloadCIS,
                            printCIS,
                            shareCIS),
                      ),
                      Flexible(
                        child: FunctionCard(
                            icons[3],
                            functionalities[3],
                            descriptions[3],
                            openBracelet,
                            downloadBracelet,
                            printBracelet,
                            shareBracelet),
                      ),
                    ],
                  )
                ],
              )
            : Center(
                child: ListView(
                  children: [
                    FunctionCard(icons[0], functionalities[0], descriptions[0],
                        openData, downloadData, printData, shareData),
                    FunctionCard(icons[1], functionalities[1], descriptions[1],
                        openBadge, downloadBadge, printBadge, shareBadge),
                    FunctionCard(icons[2], functionalities[2], descriptions[2],
                        openCIS, downloadCIS, printCIS, shareCIS),
                    FunctionCard(
                        icons[3],
                        functionalities[3],
                        descriptions[3],
                        openBracelet,
                        downloadBracelet,
                        printBracelet,
                        shareBracelet),
                  ],
                ),
              );
  }

  Widget _covidScreen() {
    return Center(
      child: ListView(
        children: [
          CovidTile("Tampone", DateTime.now(), "https://andreacalici.com/"),
          CovidTile("Tampone", DateTime.now(),
              "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
          CovidTile("Tampone", DateTime.now(),
              "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
        ],
      ),
    );
  }

  //callback functions
  openQRCode() async {
    await QRCodeHandler().openQRCode(qrCodeData);
  }

  saveQRCodeToGallery() async {
    await QRCodeHandler().saveQRCodeToGallery(qrCodeData);
  }

  printQRCode() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).printQRCode();
  }

  openData() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).openData();
  }

  downloadData() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).downloadData();
  }

  printData() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).printData();
  }

  shareData() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).shareData();
  }

  openBracelet() async {
    await PDFHandler(qrData: qrCodeData).openBracelet();
  }

  downloadBracelet() async {
    await PDFHandler(qrData: qrCodeData).downloadBracelet();
  }

  printBracelet() async {
    await PDFHandler(qrData: qrCodeData).printBracelet();
  }

  shareBracelet() async {
    await PDFHandler(qrData: qrCodeData).shareBracelet();
  }

  openBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).openBadge();
    _setProcessing(false);
  }

  downloadBadge() async {
    await PDFHandler(qrData: qrCodeData).downloadBadge();
  }

  printBadge() async {
    await PDFHandler(qrData: qrCodeData).printBadge();
  }

  shareBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).shareBadge();
    _setProcessing(false);
  }

  openCIS() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).openCIS();
  }

  downloadCIS() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).downloadCIS();
  }

  printCIS() async {
    await PDFHandler(qrData: qrCodeData, patient: patient).printCIS();
  }

  shareCIS() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).shareCIS();
    _setProcessing(false);
  }

  _setProcessing(bool status) {
    setState(() {
      processing = status;
    });
  }
}
