import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:thesis/model/patient.dart';
import 'package:thesis/widgets/function_button.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  String qrCodeData = "";
  final String qrCodeDataFake = createLifeSavingInformation(createPatient());
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("QR Code Scanner"),
      ),
      body: _createCard(),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (qrCodeData != "")
            ? (qrCodeData != "-1")
                ? Text(qrCodeData)
                : Text("")
            : Text(""),
        FunctionButton(_scanQRCode, Icon(Icons.qr_code_scanner), "Scan"),
      ],
    ));
  }

  Widget _createCard() {
    List<String> patientList = qrCodeDataFake.split("\n");
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
                            child: Text(
                                information[index] + ": " + patientList[index]),
                          )
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(information[index] + ": " + patientList[index]),
                    );
                  })),
            ),
          ),
        ),
        _buildBody(),
      ],
    );
  }

  Widget _createList() {
    List<String> patientList = qrCodeDataFake.split("\n");
    return ListView.builder(
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            title: Text('${patientList[index]}'),
            trailing: Text(information[index]),
          ),
        );
      },
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

      if (!mounted) return;

      setState(() {
        this.qrCodeData = qrCode;
      });
    } on PlatformException {
      qrCodeData = 'Failed to get platform version.';
    }
  }
}
