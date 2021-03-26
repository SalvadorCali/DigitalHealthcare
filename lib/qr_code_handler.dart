import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeHandler {
  QrImage generateQRCode(String data) {
    return QrImage(
      data: data,
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  openQRCode(String data) async {
    String path = await _createImage(data);
    if (path != "Error") {
      final result = await OpenFile.open(path);
      Fluttertoast.showToast(msg: "$result");
    }
  }

  saveQRCodeToGallery(String data) async {
    String path = await _createImage(data);
    if (path != "Error") {
      final result = await ImageGallerySaver.saveFile(path);
      Fluttertoast.showToast(msg: "$result");
    }
  }

  Future<String> _createImage(String data) async {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode,
        emptyColor: const Color(0xffffffff),
        gapless: false,
      );

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/$ts.png';

      final picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      await _writeToFile(picData, path);
      return path;
    } else {
      return "Error";
    }
  }

  Future<void> _writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
