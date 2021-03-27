import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:thesis/pdf_handler.dart';
import 'package:thesis/qr_code_handler.dart';
import 'package:thesis/widgets/function_button.dart';
import 'package:thesis/widgets/function_icon.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
            await PDFHandler().openBracelet();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _functionalitiesScreen() {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          FunctionIcon(
            icon: Icon(Icons.qr_code),
          ),
          FunctionIcon(
            icon: Icon(Icons.qr_code),
          ),
          FunctionIcon(
            icon: Icon(Icons.qr_code),
          ),
          FunctionIcon(
            icon: Icon(Icons.qr_code),
          )
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
          FunctionButton(
              onPressed: openQRCode, icon: Icon(Icons.image), label: "Apri"),
          FunctionButton(
              onPressed: saveQRCodeToGallery,
              icon: Icon(Icons.save),
              label: "Salva in Galleria"),
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
