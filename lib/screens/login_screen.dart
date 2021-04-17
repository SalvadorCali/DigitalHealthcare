import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogin(
        logo: 'assets/images/logo2.png',
        onLogin: _authUser,
        onSignup: _authUser,
        onSubmitAnimationCompleted: () {},
        onRecoverPassword: _recoverPassword,
        loginProviders: [
          LoginProvider(
            icon: Icons.qr_code_scanner,
            callback: () async {
              print('start google sign in');
              await Future.delayed(loginTime);
              print('stop google sign in');
              return null;
            },
          ),
          LoginProvider(
            icon: Icons.contact_phone_outlined,
            callback: () async {
              print('start google sign in');
              await Future.delayed(loginTime);
              print('stop google sign in');
              return null;
            },
          )
        ],
      ),
    );
  }

  printSomething() {
    print("Prova");
  }
}
