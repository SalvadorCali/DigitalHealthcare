import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:thesis/widgets/function_button.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  String qrCodeData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("QR Code Scanner"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (qrCodeData != "") ? Text(qrCodeData) : Text("Error"),
        FunctionButton(_scanQRCode, Icon(Icons.qr_code_scanner), "Scan"),
      ],
    ));
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
