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

  @override
  Widget build(BuildContext context) {
    _initializePatient();
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Thesis"),
            actions: [
              AppBarButton(Icon(Icons.contact_phone_outlined),
                  widget.openEmergencyNumbers),
              AppBarButton(
                  Icon(Icons.qr_code_scanner), widget.openQRCodeScanner),
              AppBarButton(Icon(Icons.logout), widget.changeScreen),
            ],
            bottom: TabBar(
              tabs: [
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _functionalitiesScreen() {
    return Center(
      child: ListView(
        children: [
          FunctionCard(icons[0], functionalities[0], descriptions[0], openData,
              downloadData),
          FunctionCard(icons[1], functionalities[1], descriptions[1], openBadge,
              downloadBadge),
          FunctionCard(icons[2], functionalities[2], descriptions[2], openCIS,
              downloadCIS),
          FunctionCard(icons[3], functionalities[3], descriptions[3],
              openBracelet, downloadBracelet),
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
  openQRCode() {
    QRCodeHandler().openQRCode(qrCodeData);
  }

  saveQRCodeToGallery() {
    QRCodeHandler().saveQRCodeToGallery(qrCodeData);
  }

  openData() {
    PDFHandler(qrData: qrCodeData, patient: patient).openData();
  }

  downloadData() {
    PDFHandler(qrData: qrCodeData, patient: patient).downloadData();
  }

  openBracelet() {
    PDFHandler(qrData: qrCodeData).openBracelet();
  }

  downloadBracelet() {
    PDFHandler(qrData: qrCodeData).downloadBracelet();
  }

  openBadge() {
    PDFHandler(qrData: qrCodeData).openBadge();
  }

  downloadBadge() {
    PDFHandler(qrData: qrCodeData).downloadBadge();
  }

  openCIS() {
    PDFHandler(qrData: qrCodeData, patient: patient).openCIS();
  }

  downloadCIS() {
    PDFHandler(qrData: qrCodeData, patient: patient).downloadCIS();
  }
}
