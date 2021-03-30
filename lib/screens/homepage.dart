import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/screens/emergency_numbers.dart';
import 'package:thesis/screens/qr_code_scanner.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/services/qr_code_handler.dart';
import 'package:thesis/widgets/appbar_button.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:thesis/widgets/function_card.dart';
import 'package:thesis/model/patient.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String qrCodeData = createLifeSavingInformation(createPatient());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thesis"),
          actions: [
            AppBarButton(
                Icon(Icons.contact_phone_outlined), openEmergencyNumbers),
            AppBarButton(Icon(Icons.qr_code_scanner), openQRCodeScanner),
            AppBarButton(Icon(Icons.logout), openCIS),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.qr_code)),
              Tab(icon: Icon(Icons.menu)),
            ],
          ),
        ),
        body: TabBarView(children: [_qrCodeScreen(), _functionalitiesScreen()]),
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

  Center _qrCodeScreen() {
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

  //callback functions
  openQRCode() {
    QRCodeHandler().openQRCode(qrCodeData);
  }

  saveQRCodeToGallery() {
    QRCodeHandler().saveQRCodeToGallery(qrCodeData);
  }

  openData() {
    PDFHandler(qrCodeData).openData();
  }

  downloadData() {
    PDFHandler(qrCodeData).downloadData();
  }

  openBracelet() {
    PDFHandler(qrCodeData).openBracelet();
  }

  downloadBracelet() {
    PDFHandler(qrCodeData).downloadBracelet();
  }

  openBadge() {
    PDFHandler(qrCodeData).openBadge();
  }

  downloadBadge() {
    PDFHandler(qrCodeData).downloadBadge();
  }

  openCIS() {
    PDFHandler(qrCodeData).openCIS();
  }

  downloadCIS() {
    PDFHandler(qrCodeData).downloadCIS();
  }

  openQRCodeScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRCodeScanner()),
    );
  }

  openEmergencyNumbers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmergencyNumbers()),
    );
  }
}
