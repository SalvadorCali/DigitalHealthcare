import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Preview extends StatelessWidget {
  final String path;

  Preview(this.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
