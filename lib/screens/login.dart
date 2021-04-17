import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:thesis/services/auth_service.dart';

class Login extends StatelessWidget {
  final openQRCodeScanner;
  final openEmergencyNumbers;
  final setLogged;
  final setVolunteer;
  Login(this.openQRCodeScanner, this.openEmergencyNumbers, this.setLogged,
      this.setVolunteer);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    AuthService().login(data.name, data.password);
    return null;
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
    setVolunteer();
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
        onLogin: _authUser,
        onSignup: _authUser,
        hideSignUpButton: true,
        onSubmitAnimationCompleted: () {},
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          goBackButton: "INDIETRO",
          forgotPasswordButton: "Password dimenticata?",
          recoverPasswordIntro: "Resetta la tua password qui.",
          recoverPasswordDescription:
              "Ti invieeremo un link per il reset della password a questo indirizzo e-mail.",
          recoverPasswordButton: "RESET",
        ),
        loginProviders: [
          LoginProvider(
            icon: Icons.person,
            callback: () async {
              setLogged();
              return null;
            },
          ),
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
          LoginProvider(
            icon: Icons.work,
            callback: () async {
              setVolunteer();
              return null;
            },
          ),
        ],
      ),
    );
  }
}
