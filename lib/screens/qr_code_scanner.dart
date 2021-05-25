import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/timestamp_citizen.dart';
import 'package:thesis/widgets/function_button.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  String qrCodeData = "";
  bool alignmentCenter = true;
  List<String> information = [
    "Nome",
    "Data di Nascita",
    "Gruppo Sanguigno",
    "Contatto ICE1",
    "Contatto ICE2",
    "Patologia",
    "Patologia",
    "Allergie",
    "Informazioni"
  ];

  @override
  Widget build(BuildContext context) {
    //TimestampCitizen patient = createPatient();
    //qrCodeDataFake = patient.getLifeSavingInformation();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("QR Code Scanner"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (qrCodeData != "")
            ? (qrCodeData != "-1")
                ? _createCard()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/scan_qr_error.jpg"),
                  )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/scan_qr.jpg"),
              ),
        Text("Esegui la scansione di un codice QR:"),
        FunctionButton(_scanQRCode, Icon(Icons.qr_code_scanner), "Scan"),
      ],
    );
  }

  Widget _createCard() {
    List<String> patientList = qrCodeData.split("\n");
    if (patientList.length != 9) {
      return Text("Errore nella scansione dei dati...");
    }
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(patientList.length, (index) {
                    if (index == 3 || index == 5 || index == 8) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                text: '${information[index]}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: patientList[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          text: '${information[index]}: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: patientList[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ),
        ),
      ],
    );
  }

  _scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      //final qrCode = await QrUtils.scanQR;

      if (!mounted) return;

      setState(() {
        this.qrCodeData = qrCode;
      });
    } on PlatformException {
      qrCodeData = 'Failed to get platform version.';
    }
  }
}
