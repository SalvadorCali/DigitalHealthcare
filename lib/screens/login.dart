import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:thesis/services/auth_service.dart';

class Login extends StatelessWidget {
  final setLogged;
  final openQRCodeScanner;
  final openEmergencyNumbers;
  Login(this.setLogged, this.openQRCodeScanner, this.openEmergencyNumbers);

  Duration get loginTime => Duration(milliseconds: 1500);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      bool result = await AuthService().login(data.name, data.password);
      if (!result) {
        return "Wrong user";
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) async {
      bool result = await AuthService().resetPassword(name);
      if (!result) {
        return "Error";
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: FlutterLogin(
          title: "Digital Healthcare",
          titleTag: "Digital Healthcare",
          onLogin: _authUser,
          onSignup: _authUser,
          hideSignUpButton: true,
          onSubmitAnimationCompleted: () {
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
          loginProviders: kIsWeb
              ? []
              : [
                  LoginProvider(
                    icon: Icons.qr_code_scanner,
                    callback: () async {
                      await Future.delayed(loginTime);
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
      ),
    ]);
  }
}
