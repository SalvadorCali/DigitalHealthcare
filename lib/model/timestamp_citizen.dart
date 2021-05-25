import 'package:thesis/constants.dart';

class TimestampCitizen {
  String bloodGroup;
  String bloodFactor;
  String contactOne;
  int phoneNumberOne;
  String contactTwo;
  int phoneNumberTwo;
  List<String> pathologies;
  String allergies;
  String information;

  String adi;
  String adp;
  String bmi;
  String cap;
  String cf;
  String allergieCutaneeRespiratorieSistemiche;
  String allergieVelenoImenotteri;
  String altezza;
  String anamnesiFamigliari;
  String attivitaLavorativa;
  String ausili;
  String capacitaMotoriaAssistito;
  String codiceATS;
  String codiceEsenzione;
  String cognome;
  String comuneDomicilio;
  String comuneNascita;
  String contattoCareGiver;
  String dataNascita;
  String donazioneOrgani;
  String email;
  String fattoreRH;
  String fattoriRischio;
  String gravidanzeParti;
  String gruppoSanguigno;
  String indirizzoDomicilio;
  String nome;
  String organiMancanti;
  List<String> patologieCronicheRilevanti;
  List<String> patologieInAtto;
  String pec;
  String peso;
  String pressioneArteriosa;
  String protesi;
  String provinciaDomicilio;
  String provinciaNascita;
  String reazioniAvverseFarmaciAlimenti;
  String retiPatologieAssistito;
  String rilevantiMalformazioni;
  String sesso;
  String telefono;
  String telefonoCareGiver;
  String terapieFarmacologiche;
  String terapieFarmacologicheCroniche;
  String trapianti;
  String vaccinazioni;

  TimestampCitizen(
      {this.bloodGroup,
      this.bloodFactor,
      this.contactOne,
      this.phoneNumberOne,
      this.contactTwo,
      this.phoneNumberTwo,
      this.pathologies,
      this.allergies,
      this.information,
      this.adi,
      this.adp,
      this.bmi,
      this.cap,
      this.cf,
      this.allergieCutaneeRespiratorieSistemiche,
      this.allergieVelenoImenotteri,
      this.altezza,
      this.anamnesiFamigliari,
      this.attivitaLavorativa,
      this.ausili,
      this.capacitaMotoriaAssistito,
      this.codiceATS,
      this.codiceEsenzione,
      this.cognome,
      this.comuneDomicilio,
      this.comuneNascita,
      this.contattoCareGiver,
      this.dataNascita,
      this.donazioneOrgani,
      this.email,
      this.fattoreRH,
      this.fattoriRischio,
      this.gravidanzeParti,
      this.gruppoSanguigno,
      this.indirizzoDomicilio,
      this.nome,
      this.organiMancanti,
      this.patologieCronicheRilevanti,
      this.patologieInAtto,
      this.pec,
      this.peso,
      this.pressioneArteriosa,
      this.protesi,
      this.provinciaDomicilio,
      this.provinciaNascita,
      this.reazioniAvverseFarmaciAlimenti,
      this.retiPatologieAssistito,
      this.rilevantiMalformazioni,
      this.sesso,
      this.telefono,
      this.telefonoCareGiver,
      this.terapieFarmacologiche,
      this.terapieFarmacologicheCroniche,
      this.trapianti,
      this.vaccinazioni});

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'surname': cognome,
      'birthday': dataNascita,
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
      'Nome': nome + " " + cognome,
      'Data di nascita': dataNascita,
      'Gruppo sanguigno': bloodGroup + bloodFactor,
      'Contatto ICE1': contactOne + "-" + phoneNumberOne.toString(),
      'Contatto ICE2': contactTwo + "-" + phoneNumberTwo.toString(),
      'Patologie': pathologies,
      'Allergie': allergies,
      'Informazioni': information
    };
  }

  String getLifeSavingInformation() {
    return /* datiSalvavita +
        aCapo +
         */
        nome +
            space +
            cognome +
            aCapo +
            dataNascita +
            aCapo +
            bloodGroup +
            bloodFactor +
            aCapo +
            contactOne +
            colon +
            space +
            phoneNumberOne.toString() +
            aCapo +
            contactTwo +
            colon +
            space +
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
