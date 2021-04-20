import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:thesis/services/auth_service.dart';

class Login extends StatelessWidget {
  String email;
  String password;
  final setLogged;
  final openQRCodeScanner;
  final openEmergencyNumbers;
  Login(this.setLogged, this.openQRCodeScanner, this.openEmergencyNumbers);

  Duration get loginTime => Duration(milliseconds: 1500);

  Future<String> _authUser(LoginData data) {
    email = data.name;
    password = data.password;
    return Future.delayed(loginTime).then((_) async {
      bool result = await AuthService().login(data.name, data.password);
      if (!result) {
        return "Wrong user";
      }
      return null;
    });

    /* print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    }); */
  }

  Future<String> _recoverPassword(String name) {
    return null;
    /* print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogin(
        //logo: 'assets/images/logo2.png',
        title: "PSS + CIS",
        titleTag: "PSS + CIS",
        onLogin: _authUser,
        onSignup: _authUser,
        hideSignUpButton: true,
        onSubmitAnimationCompleted: () {
          /*  bool result = await AuthService().login(email, password);
      if (!result) {
        return reload();
      }
      return null; */
          print("Prorro");
          setLogged();
        },
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          goBackButton: "INDIETRO",
          forgotPasswordButton: "Password dimenticata?",
          recoverPasswordIntro: "Resetta la tua password qui.",
          recoverPasswordDescription:
              "Ti invieeremo un link per il reset della password a questo indirizzo e-mail.",
          recoverPasswordButton: "RESET",
        ),
        loginProviders:
            /* kIsWeb
            ? []
            :  */
            [
          LoginProvider(
            icon: Icons.qr_code_scanner,
            callback: () async {
              //await Future.delayed(loginTime);
              openQRCodeScanner();
              return null;
            },
          ),
          LoginProvider(
            icon: Icons.contact_phone_outlined,
            callback: () async {
              await Future.delayed(loginTime);
              openEmergencyNumbers();
              return null;
            },
          ),
        ],
      ),
    );
  }
}
