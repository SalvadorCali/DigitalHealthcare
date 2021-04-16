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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'birthday': birthday,
      'bloodGroup': bloodGroup,
      'bloodFactor': bloodFactor,
      'contactOne': contactOne,
      'phoneNumberOne': phoneNumberOne,
      'contactTwo': contactTwo,
      'phoneNumberTwo': phoneNumberTwo,
      'pathologies': pathologies,
      'allergies': allergies,
      'information': information
    };
  }

  Map<String, dynamic> toMapIta() {
    return {
      'Nome': name + " " + surname,
      'Data di nascita': birthday,
      'Gruppo sanguigno': bloodGroup + bloodFactor,
      'Contatto ICE1': contactOne + "-" + phoneNumberOne.toString(),
      'Contatto ICE2': contactTwo + "-" + phoneNumberTwo.toString(),
      'Patologie': pathologies,
      'Allergie': allergies,
      'Informazioni': information
    };
  }

  String getLifeSavingInformation() {
    return name +
        space +
        surname +
        aCapo +
        birthday +
        aCapo +
        bloodGroup +
        bloodFactor +
        aCapo +
        contactOne +
        colon +
        phoneNumberOne.toString() +
        aCapo +
        contactTwo +
        colon +
        phoneNumberTwo.toString() +
        aCapo +
        pathologies[0] +
        aCapo +
        pathologies[1] +
        aCapo +
        allergies +
        aCapo +
        information;
  }
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
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac molestie lorem, eget semper odio. In purus lacus, scelerisque quis nisl ac, maximus cursus orci. Vestibulum vitae libero erat.");
}

Patient createPatientWithName(String name, String surname) {
  return Patient(
      name,
      surname,
      "19/04/1996",
      "A",
      "-",
      "Mamma",
      333,
      "Papà",
      444,
      ["Patologia1", "Patologia2"],
      "Graminacee",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac molestie lorem, eget semper odio. In purus lacus, scelerisque quis nisl ac, maximus cursus orci. Vestibulum vitae libero erat.");
}
