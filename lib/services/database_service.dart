import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/end_user.dart';
import 'package:thesis/model/citizen.dart';
import 'package:thesis/model/timestamp_citizen.dart';
import 'package:thesis/model/timestamp_covid.dart';
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
    Map<String, TimestampCitizen> citizenMap;
    Map<String, TimestampCovid> covidMap;
    await citizens.doc(tin).get().then((value) => {
          name = value["nome"],
          surname = value["cognome"],
          photoURL = value["photoURL"]
        });
    await citizens.doc(tin).collection('data').get().then((value) {
      citizenMap = _citizenFromFirebase(value);
    });
    await citizens.doc(tin).collection('covid19').get().then((value) {
      covidMap = _covidFromFirebase(value);
    });
    return Citizen(tin, name, surname, photoURL, citizenMap, covidMap);
  }

  Map<String, TimestampCitizen> _citizenFromFirebase(QuerySnapshot snapshot) {
    Map<String, TimestampCitizen> data = Map();
    TimestampCitizen patient;
    snapshot.docs.forEach((element) {
      patient = TimestampCitizen(
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
          areaUtenza: element["areaUtenza"],
          attivitaLavorativa: element["attivitaLavorativa"],
          ausili: element["ausili"],
          capacitaMotoriaAssistito: element["capacitaMotoriaAssistito"],
          codiceATS: element["codiceATS"],
          codiceEsenzione: element["codiceEsenzione"],
          cognome: element["cognome"],
          comuneDomicilio: element["comuneDomicilio"],
          comuneNascita: element["comuneNascita"],
          comuneRilascio: element["comuneRilascio"],
          contatto1: element["contatto1"],
          contatto2: element["contatto2"],
          contattoCareGiver: element["contattoCareGiver"],
          dataNascita: element["dataNascita"],
          dataScadenza: element["dataScadenza"],
          donazioneOrgani: element["donazioneOrgani"],
          email: element["email"],
          fattoreRH: element["fattoreRH"],
          fattoriRischio: element["fattoriRischio"],
          gravidanzeParti: element["gravidanzeParti"],
          gruppoSanguigno: element["gruppoSanguigno"],
          indirizzoDomicilio: element["indirizzoDomicilio"],
          nome: element["nome"],
          numeroCartaIdentita: element["numeroCartaIdentità"],
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
          servizioAssociazione: element["servizioAssociazione"],
          sesso: element["sesso"],
          telefono: element["telefono"],
          telefono1: element["telefono1"],
          telefono2: element["telefono2"],
          telefonoCareGiver: element["telefonoCareGiver"],
          terapieFarmacologiche: element["terapieFarmacologiche"],
          terapieFarmacologicheCroniche:
              element["terapieFarmacologicheCroniche"],
          trapianti: element["trapianti"],
          vaccinazioni: element["vaccinazioni"],
          viveSolo: element["viveSolo"]);
      data.addAll({fromMillisecondsToDate(element.id): patient});
    });
    return data;
  }

  Map<String, TimestampCovid> _covidFromFirebase(QuerySnapshot snapshot) {
    Map<String, TimestampCovid> data = Map();
    TimestampCovid covid;
    snapshot.docs.forEach((element) {
      covid = TimestampCovid(
          data: element["data"],
          esito: element["esito"],
          link: element["link"],
          nomeVaccino: element["nomeVaccino"],
          tipologia: element["tipologia"]);
      data.addAll({fromStringToDate(covid.data): covid});
    });
    return data;
  }

  Future<List<Citizen>> getCitizensList(String tin) {
    Map<String, TimestampCitizen> citizensMap = Map();
    Map<String, TimestampCovid> covidMap = Map();
    return citizens.where("CFVolontario", isEqualTo: tin).get().then((value) =>
        value.docs
            .map((e) => Citizen(e.id, e["nome"], e["cognome"], e["photoURL"],
                citizensMap, covidMap))
            .toList());
  }

  populateCitizensData(List<Citizen> citizensList) {
    citizensList.forEach((element) {
      citizens.doc(element.cf).collection("data").get().then((value) {
        element.data = _citizenFromFirebase(value);
      });
      citizens
          .doc(element.cf)
          .collection("covid19")
          .orderBy("data")
          .get()
          .then((value) {
        element.covid = _covidFromFirebase(value);
      });
    });
  }
}
