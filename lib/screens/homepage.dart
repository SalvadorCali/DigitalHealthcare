import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/services/qr_code_handler.dart';
import 'package:thesis/widgets/appbar_button.dart';
import 'package:thesis/widgets/covid_tile.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:thesis/widgets/function_card.dart';

class Homepage extends StatefulWidget {
  final Citizen citizen;
  final openQRCodeScanner;
  final openEmergencyNumbers;
  final changeScreen;
  Homepage(this.citizen, this.openQRCodeScanner, this.openEmergencyNumbers,
      this.changeScreen);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String qrCodeData;
  String qrCodeCovid;
  String currentDate;

  @override
  void initState() {
    _initializeCitizen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Homepage"),
              actions: [
                AppBarButton(Icon(Icons.contact_phone_outlined),
                    widget.openEmergencyNumbers),
                kIsWeb
                    ? SizedBox.shrink()
                    : AppBarButton(
                        Icon(Icons.qr_code_scanner), widget.openQRCodeScanner),
                _buildDateMenu(),
                AppBarButton(Icon(Icons.logout), widget.changeScreen),
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
            body: TabBarView(children: [
              _qrCodeScreen(qrCodeData),
              _functionalitiesScreen(),
              _covidScreen()
            ])));
  }

  PopupMenuButton _buildDateMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.calendar_today),
      initialValue: currentDate,
      itemBuilder: (BuildContext context) {
        return widget.citizen.data.keys.map((element) {
          return PopupMenuItem(
            value: element,
            child: Text(element),
          );
        }).toList();
      },
      onSelected: (value) {
        setState(() {
          currentDate = value;
          qrCodeData = widget.citizen.data[value].getLifeSavingInformation();
          qrCodeCovid = widget.citizen.data[value].getLifeSavingInformation();
        });
      },
    );
  }

  _initializeCitizen() {
    setState(() {
      currentDate = widget.citizen.data.keys.last;
      qrCodeData = widget.citizen.data[currentDate].getLifeSavingInformation();
      //da modificare inserendo i dati covid
      qrCodeCovid = widget.citizen.data[currentDate].getLifeSavingInformation();
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
    return (kIsWeb &&
            MediaQuery.of(context).size.width >
                MediaQuery.of(context).size.height)
        ? ListView(
            children: [
              Row(
                children: [
                  Flexible(
                    child: FunctionCard(
                        icons[0],
                        images[0],
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
                        images[1],
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
                        images[2],
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
                        images[3],
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
                      images[0],
                      functionalities[0],
                      subtitles[0],
                      descriptions[0],
                      openData,
                      downloadData,
                      printData,
                      shareData),
                  FunctionCard(
                      icons[1],
                      images[1],
                      functionalities[1],
                      subtitles[1],
                      descriptions[1],
                      openBadge,
                      downloadBadge,
                      printBadge,
                      shareBadge),
                  FunctionCard(
                      icons[2],
                      images[2],
                      functionalities[2],
                      subtitles[2],
                      descriptions[2],
                      openCIS,
                      downloadCIS,
                      printCIS,
                      shareCIS),
                  FunctionCard(
                      icons[3],
                      images[3],
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
              CovidTile(
                  "Vaccinazione", DateTime.now(), "https://andreacalici.com/"),
              CovidTile("Tampone", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
              CovidTile("Sierologico", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
              CovidTile("Tampone", DateTime.now(),
                  "https://andreacalici.files.wordpress.com/2021/03/aamas.pdf"),
            ],
          );
  }

  //callback functions
  openQRCode() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      QRCodeHandler().openQRCode(qrCodeData).whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  saveQRCodeToGallery() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      QRCodeHandler().saveQRCodeToGallery(qrCodeData).whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  printQRCode() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .printQRCode()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  openData() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .openData()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  downloadData() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .downloadData()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  printData() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .printData()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  shareData() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .shareData()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  openBracelet() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .openBracelet()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  downloadBracelet() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .downloadBracelet()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  printBracelet() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .printBracelet()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  shareBracelet() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(timestampCitizen: widget.citizen.data[currentDate])
          .shareBracelet()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  openBadge() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .openBadge()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  downloadBadge() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .downloadBadge()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  printBadge() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .printBadge()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  shareBadge() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .shareBadge()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  openCIS() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .openCIS()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  downloadCIS() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .downloadCIS()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  printCIS() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .printCIS()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  shareCIS() async {
    _setProcessing(true);
    await Future.delayed(Duration(seconds: 1), () {
      PDFHandler(
              citizen: widget.citizen,
              timestampCitizen: widget.citizen.data[currentDate])
          .shareCIS()
          .whenComplete(() {
        _setProcessing(false);
      });
    });
  }

  _setProcessing(bool status) {
    status ? _showLoadingDialog() : Navigator.of(context).pop();
  }

  Future<void> _showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.upload_file),
                ),
                Center(child: Text('Generazione documento in corso...')),
              ],
            ),
          ),
        );
      },
    );
  }
}
