import 'package:thesis/constants.dart';

class Doctor {
  String cf;
  String nome;
  String cognome;
  String pec;
  String telefono;

  Doctor(
    this.cf,
    this.nome,
    this.cognome,
    this.pec,
    this.telefono,
  );

  String fullName() {
    return nome + space + cognome;
  }
}
