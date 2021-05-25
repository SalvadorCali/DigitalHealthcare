import 'package:thesis/model/timestamp_citizen.dart';

class Citizen {
  String cf;
  String name;
  String surname;
  String photoURL;
  Map<String, TimestampCitizen> data;

  Citizen(this.cf, this.name, this.surname, this.photoURL, this.data);

  String get fullName {
    return name + " " + surname;
  }
}
