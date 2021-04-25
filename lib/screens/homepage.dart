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
  Map<String, Patient> dateArchive = Map();
  final Patient patient = createPatient();
  final Patient patient2 = createPatientWithName("Davide", "Laffi");
  final Patient patient3 = createPatientWithName("Simona", "Di Nunno");
  String qrCodeData;
  bool processing = false;
  bool hideQR = false;
  bool floatingButton = false;
  String date = "A";

  @override
  void initState() {
    _initializePatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: AppBarButton(Icon(Icons.logout), widget.changeScreen),
            title: Text("Homepage"),
            actions: [
              AppBarButton(Icon(Icons.contact_phone_outlined),
                  widget.openEmergencyNumbers),
              kIsWeb
                  ? SizedBox.shrink()
                  : AppBarButton(
                      Icon(Icons.qr_code_scanner), widget.openQRCodeScanner),
              _buildDateMenu(),
            ],
            bottom: TabBar(
              tabs: (kIsWeb &&
                      MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.height)
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
                  return TabBarView(children: [
                    _qrCodeScreen(qrCodeData),
                    _functionalitiesScreen(),
                    _covidScreen()
                  ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  PopupMenuButton _buildDateMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      initialValue: date,
      itemBuilder: (BuildContext context) {
        return dateArchive.keys.map((element) {
          return PopupMenuItem(
            value: element,
            child: Text(element),
          );
        }).toList();
      },
      onSelected: (value) {
        setState(() {
          date = value;
          qrCodeData = dateArchive[value].getLifeSavingInformation();
        });
      },
    );
  }

  _initializePatient() {
    setState(() {
      date = "30 aprile";
      dateArchive = {
        "30 aprile": patient,
        "30 marzo": patient2,
        "30 febbraio": patient3,
      };
      qrCodeData = patient.getLifeSavingInformation();
    });
  }

  Widget _qrCodeScreen(String qrData) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QRCodeHandler().generateQRCode(qrData),
            ),
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
      ),
    );
  }

  Widget _functionalitiesScreen() {
    return processing
        ? ProcessingIndicator("Generazione PDF")
        : (kIsWeb &&
                MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height)
            ? ListView(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FunctionCard(
                            icons[0],
                            functionalities[0],
                            subtitles[0],
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
                            subtitles[1],
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
                            subtitles[2],
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
                            subtitles[3],
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
                child: Scrollbar(
                  child: ListView(
                    children: [
                      FunctionCard(
                          icons[0],
                          functionalities[0],
                          subtitles[0],
                          descriptions[0],
                          openData,
                          downloadData,
                          printData,
                          shareData),
                      FunctionCard(
                          icons[1],
                          functionalities[1],
                          subtitles[1],
                          descriptions[1],
                          openBadge,
                          downloadBadge,
                          printBadge,
                          shareBadge),
                      FunctionCard(
                          icons[2],
                          functionalities[2],
                          subtitles[2],
                          descriptions[2],
                          openCIS,
                          downloadCIS,
                          printCIS,
                          shareCIS),
                      FunctionCard(
                          icons[3],
                          functionalities[3],
                          subtitles[3],
                          descriptions[3],
                          openBracelet,
                          downloadBracelet,
                          printBracelet,
                          shareBracelet),
                    ],
                  ),
                ),
              );
  }

  Widget _covidScreen() {
    return (kIsWeb &&
            MediaQuery.of(context).size.width >
                MediaQuery.of(context).size.height)
        ? Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: _qrCodeScreen(qrCodeData)),
              Flexible(
                child: Scrollbar(
                  child: ListView(
                    children: [
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.com/"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.com/"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                      CovidTile("Tampone", DateTime.now(),
                          "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
                    ],
                  ),
                ),
              ),
            ],
          )
        : ListView(
            children: [
              _qrCodeScreen(qrCodeData),
              CovidTile("Tampone", DateTime.now(), "https://andreacalici.com/"),
              CovidTile("Tampone", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
              CovidTile("Tampone", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
              CovidTile("Tampone", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
            ],
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
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).openData();
    _setProcessing(false);
  }

  downloadData() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).downloadData();
    _setProcessing(false);
  }

  printData() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).printData();
    _setProcessing(false);
  }

  shareData() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).shareData();
    _setProcessing(false);
  }

  openBracelet() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).openBracelet();
    _setProcessing(false);
  }

  downloadBracelet() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).downloadBracelet();
    _setProcessing(false);
  }

  printBracelet() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).printBracelet();
    _setProcessing(false);
  }

  shareBracelet() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).shareBracelet();
    _setProcessing(false);
  }

  openBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).openBadge();
    _setProcessing(false);
  }

  downloadBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).downloadBadge();
    _setProcessing(false);
  }

  printBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).printBadge();
    _setProcessing(false);
  }

  shareBadge() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData).shareBadge();
    _setProcessing(false);
  }

  openCIS() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).openCIS();
    _setProcessing(false);
  }

  downloadCIS() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).downloadCIS();
    _setProcessing(false);
  }

  printCIS() async {
    _setProcessing(true);
    await PDFHandler(qrData: qrCodeData, patient: patient).printCIS();
    _setProcessing(false);
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
