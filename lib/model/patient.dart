import 'package:thesis/model/timestamp_patient.dart';

class Patient {
  String tin;
  String name;
  String surname;
  Map<String, TimestampPatient> data;

  Patient(this.tin, this.name, this.surname, this.data);

  String get fullName {
    return name + " " + surname;
  }
}
