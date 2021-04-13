import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/widgets/appbar_button.dart';
import 'package:thesis/widgets/form_text_field.dart';
import 'package:thesis/widgets/function_button.dart';

class Login extends StatefulWidget {
  final openQRCodeScanner;
  final openEmergencyNumbers;
  final changeScreen;
  Login(this.openQRCodeScanner, this.openEmergencyNumbers, this.changeScreen);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          kIsWeb
              ? SizedBox.shrink()
              : AppBarButton(Icon(Icons.contact_phone_outlined),
                  widget.openEmergencyNumbers),
          kIsWeb
              ? SizedBox.shrink()
              : AppBarButton(
                  Icon(Icons.qr_code_scanner), widget.openQRCodeScanner),
          AppBarButton(Icon(Icons.login), widget.changeScreen),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    TextEditingController email;
    TextEditingController password;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    FormTextField(email, Icon(Icons.email), "E-Mail",
                        "Please provide a valid e-mail", false),
                    FormTextField(password, Icon(Icons.lock), "Password",
                        "Please provide a valid password", true),
                  ],
                ),
              ),
            ),
          ),
          FunctionButton(_login, Icon(Icons.login), "Login"),
        ],
      ),
    );
  }

  _login() {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }
}
