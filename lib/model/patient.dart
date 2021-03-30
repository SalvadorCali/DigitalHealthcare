import 'package:thesis/constants.dart';

class Patient {
  String name;
  String surname;
  String birthday;
  String bloodGroup;
  String bloodFactor;
  String contactOne;
  int phoneNumberOne;
  String contactTwo;
  int phoneNumberTwo;
  List<String> pathologies;
  String allergies;
  String information;

  Patient(
      this.name,
      this.surname,
      this.birthday,
      this.bloodGroup,
      this.bloodFactor,
      this.contactOne,
      this.phoneNumberOne,
      this.contactTwo,
      this.phoneNumberTwo,
      this.pathologies,
      this.allergies,
      this.information);
}

Patient createPatient() {
  return Patient(
      "Andrea",
      "Calici",
      "19/04/1996",
      "A",
      "-",
      "Mamma",
      333,
      "Papà",
      444,
      ["Patologia1", "Patologia2"],
      "Graminacee",
      "Nessuna informazione");
}

String createLifeSavingInformation(Patient patient) {
  return patient.name +
      space +
      patient.surname +
      aCapo +
      patient.birthday +
      aCapo +
      patient.bloodGroup +
      patient.bloodFactor +
      aCapo +
      patient.contactOne +
      colon +
      patient.phoneNumberOne.toString() +
      aCapo +
      patient.contactTwo +
      colon +
      patient.phoneNumberTwo.toString() +
      aCapo +
      patient.pathologies[0] +
      aCapo +
      patient.pathologies[1] +
      aCapo +
      patient.allergies +
      aCapo +
      patient.information;
}
