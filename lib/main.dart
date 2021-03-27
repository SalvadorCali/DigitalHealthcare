import 'package:flutter/material.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/services/qr_code_handler.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:thesis/widgets/function_card.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Thesis'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String data = "andrea calici";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.qr_code)),
              Tab(icon: Icon(Icons.menu)),
            ],
          ),
        ),
        body: TabBarView(children: [_qrCodeScreen(), _functionalitiesScreen()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await PDFHandler(data).openBracelet();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _functionalitiesScreen() {
    return Center(
      child: ListView(
        children: [
          FunctionCard(icons[0], functionalities[0], descriptions[0]),
          FunctionCard(icons[1], functionalities[1], descriptions[1]),
          FunctionCard(icons[2], functionalities[2], descriptions[2]),
          FunctionCard(icons[3], functionalities[3], descriptions[3]),
        ],
      ),
    );
  }

//prova
  Center _qrCodeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QRCodeHandler().generateQRCode(data),
          FunctionButton(openQRCode, Icon(Icons.image), "Apri"),
          FunctionButton(
              saveQRCodeToGallery, Icon(Icons.save), "Salva in Galleria"),
        ],
      ),
    );
  }

  openQRCode() {
    QRCodeHandler().openQRCode(data);
  }

  saveQRCodeToGallery() {
    QRCodeHandler().saveQRCodeToGallery(data);
  }
}
