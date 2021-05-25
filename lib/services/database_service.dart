import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/end_user.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/model/timestamp_citizen.dart';
import 'package:thesis/services/auth_service.dart';

class DatabaseService {
  AuthService _auth = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference citizens =
      FirebaseFirestore.instance.collection('citizens');

  Future<EndUser> getUser() {
    return users
        .doc(_auth.getCurrentUser().uid)
        .get()
        .then((value) => _userFromFirebase(value));
  }

  EndUser _userFromFirebase(DocumentSnapshot snapshot) {
    return EndUser(
        uid: snapshot.data()['uid'],
        cf: snapshot.data()['CF'],
        email: snapshot.data()['email'],
        photoURL: snapshot.data()['photoURL'],
        userType: snapshot.data()['userType']);
  }

  Future<Citizen> getCitizen(String tin) async {
    String name;
    String surname;
    String photoURL;
    await citizens.doc(tin).get().then((value) => {
          name = value["nome"],
          surname = value["cognome"],
          photoURL = value["photoURL"]
        });
    return citizens.doc(tin).collection('data').get().then((value) {
      return Citizen(tin, name, surname, photoURL, _citizenFromFirebase(value));
    });
  }

  Map<String, TimestampCitizen> _citizenFromFirebase(QuerySnapshot snapshot) {
    Map<String, TimestampCitizen> data = Map();
    TimestampCitizen patient;
    snapshot.docs.forEach((element) {
      patient = TimestampCitizen(
          bloodGroup: "A",
          bloodFactor: "-",
          contactOne: "Mamma",
          phoneNumberOne: 333,
          contactTwo: "Papà",
          phoneNumberTwo: 444,
          pathologies: ["Patologia1", "Patologia2"],
          allergies: "Graminacee",
          information:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac molestie lorem, eget semper odio. In purus lacus, scelerisque quis nisl ac, maximus cursus orci. Vestibulum vitae libero erat.",
          adi: element["ADI"],
          adp: element["ADP"],
          bmi: element["BMI"],
          cap: element["CAP"],
          cf: element["CF"],
          allergieCutaneeRespiratorieSistemiche:
              element["allergieCutaneeRespiratorieSistemiche"],
          allergieVelenoImenotteri: element["allergieVelenoImenotteri"],
          altezza: element["altezza"],
          anamnesiFamigliari: element["anamnesiFamigliari"],
          attivitaLavorativa: element["attivitaLavorativa"],
          ausili: element["ausili"],
          capacitaMotoriaAssistito: element["capacitaMotoriaAssistito"],
          codiceATS: element["codiceATS"],
          codiceEsenzione: element["codiceEsenzione"],
          cognome: element["cognome"],
          comuneDomicilio: element["comuneDomicilio"],
          comuneNascita: element["comuneNascita"],
          contattoCareGiver: element["contattoCareGiver"],
          dataNascita: element["dataNascita"],
          donazioneOrgani: element["donazioneOrgani"],
          email: element["email"],
          fattoreRH: element["fattoreRH"],
          fattoriRischio: element["fattoriRischio"],
          gravidanzeParti: element["gravidanzeParti"],
          gruppoSanguigno: element["gruppoSanguigno"],
          indirizzoDomicilio: element["indirizzoDomicilio"],
          nome: element["nome"],
          organiMancanti: element["organiMancanti"],
          patologieCronicheRilevanti:
              List.from(element["patologieCronicheRilevanti"]),
          patologieInAtto: List.from(element["patologieInAtto"]),
          pec: element["pec"],
          peso: element["peso"],
          pressioneArteriosa: element["pressioneArteriosa"],
          protesi: element["protesi"],
          provinciaDomicilio: element["provinciaDomicilio"],
          provinciaNascita: element["provinciaNascita"],
          reazioniAvverseFarmaciAlimenti:
              element["reazioniAvverseFarmaciAlimenti"],
          retiPatologieAssistito: element["retiPatologieAssistito"],
          rilevantiMalformazioni: element["rilevantiMalformazioni"],
          sesso: element["sesso"],
          telefono: element["telefono"],
          telefonoCareGiver: element["telefonoCareGiver"],
          terapieFarmacologiche: element["terapieFarmacologiche"],
          terapieFarmacologicheCroniche:
              element["terapieFarmacologicheCroniche"],
          trapianti: element["trapianti"],
          vaccinazioni: element["vaccinazioni"]);
      data.addAll({fromMillisecondsToDate(element.id): patient});
    });
    return data;
  }

  Future<List<Citizen>> getCitizensList(String tin) {
    Map<String, TimestampCitizen> map = Map();
    return citizens.where("CFVolontario", isEqualTo: tin).get().then((value) =>
        value.docs
            .map((e) =>
                Citizen(e.id, e["nome"], e["cognome"], e["photoURL"], map))
            .toList());
  }

  populateCitizensData(List<Citizen> citizensList) {
    citizensList.forEach((element) {
      citizens.doc(element.cf).collection("data").get().then((value) {
        element.data = _citizenFromFirebase(value);
      });
    });
  }
}
