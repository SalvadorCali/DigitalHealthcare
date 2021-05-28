import 'package:thesis/constants.dart';

class TimestampCitizen {
  /* String bloodGroup; //gruppo sanguigno
  String bloodFactor; //fattore RH
  String contactOne;
  int phoneNumberOne;
  String contactTwo;
  int phoneNumberTwo;
  List<String> pathologies; //croniche
  String allergies;
  String information; */

  String adi;
  String adp;
  String bmi;
  String cap;
  String cf;
  String allergieCutaneeRespiratorieSistemiche; //allergie
  String allergieVelenoImenotteri; //allergie
  String altezza;
  String anamnesiFamigliari;
  String areaUtenza;
  String attivitaLavorativa;
  String ausili;
  String capacitaMotoriaAssistito;
  String codiceATS;
  String codiceEsenzione;
  String cognome;
  String comuneDomicilio;
  String comuneNascita;
  String comuneRilascio;
  String contatto1;
  String contatto2;
  String contattoCareGiver;
  String dataNascita;
  String dataScadenza;
  String donazioneOrgani;
  String email;
  String fattoreRH;
  String fattoriRischio;
  String gravidanzeParti;
  String gruppoSanguigno;
  String indirizzoDomicilio;
  String nome;
  String numeroCartaIdentita;
  String organiMancanti;
  List<String> patologieCronicheRilevanti; //patologie
  List<String> patologieInAtto; //patologie
  String pec;
  String peso;
  String pressioneArteriosa;
  String protesi;
  String provinciaDomicilio;
  String provinciaNascita;
  String reazioniAvverseFarmaciAlimenti; //allergie
  String retiPatologieAssistito;
  String rilevantiMalformazioni;
  String servizioAssociazione;
  String sesso;
  String telefono;
  String telefono1;
  String telefono2;
  String telefonoCareGiver;
  String terapieFarmacologiche;
  String terapieFarmacologicheCroniche;
  String trapianti;
  String vaccinazioni;
  String viveSolo;

  TimestampCitizen(
      {this.adi,
      this.adp,
      this.bmi,
      this.cap,
      this.cf,
      this.allergieCutaneeRespiratorieSistemiche,
      this.allergieVelenoImenotteri,
      this.altezza,
      this.anamnesiFamigliari,
      this.areaUtenza,
      this.attivitaLavorativa,
      this.ausili,
      this.capacitaMotoriaAssistito,
      this.codiceATS,
      this.codiceEsenzione,
      this.cognome,
      this.comuneDomicilio,
      this.comuneNascita,
      this.comuneRilascio,
      this.contatto1,
      this.contatto2,
      this.contattoCareGiver,
      this.dataNascita,
      this.dataScadenza,
      this.donazioneOrgani,
      this.email,
      this.fattoreRH,
      this.fattoriRischio,
      this.gravidanzeParti,
      this.gruppoSanguigno,
      this.indirizzoDomicilio,
      this.nome,
      this.numeroCartaIdentita,
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
      this.servizioAssociazione,
      this.sesso,
      this.telefono,
      this.telefono1,
      this.telefono2,
      this.telefonoCareGiver,
      this.terapieFarmacologiche,
      this.terapieFarmacologicheCroniche,
      this.trapianti,
      this.vaccinazioni,
      this.viveSolo});

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'surname': cognome,
      'birthday': dataNascita,
      'bloodGroup': gruppoSanguigno,
      'bloodFactor': fattoreRH,
      'contactOne': contatto1,
      'phoneNumberOne': telefono1,
      'contactTwo': contatto2,
      'phoneNumberTwo': telefono2,
      'pathologies': patologieCronicheRilevanti,
      'allergies': allergieCutaneeRespiratorieSistemiche,
    };
  }

  Map<String, dynamic> toMapIta() {
    return {
      'Nome': nome + " " + cognome,
      'Data di nascita': dataNascita,
      'Gruppo sanguigno': gruppoSanguigno + fattoreRH,
      'Contatto ICE1': contatto1 + "-" + telefono1,
      'Contatto ICE2': contatto2 + "-" + telefono2,
      'Patologie': patologieCronicheRilevanti,
      'Allergie': allergieCutaneeRespiratorieSistemiche
    };
  }

  String getLifeSavingInformation() {
    return datiSalvavita +
        aCapo +
        "Nome: " +
        nome +
        space +
        cognome +
        aCapo +
        "Data di nascita: " +
        dataNascita +
        aCapo +
        "Gruppo sanguigno: " +
        gruppoSanguigno +
        fattoreRH +
        aCapo +
        contatto1 +
        colon +
        space +
        telefono1 +
        aCapo +
        contatto2 +
        colon +
        space +
        telefono2 +
        aCapo +
        "Patologie: " +
        patologieCronicheRilevanti.toString() +
        aCapo +
        "Allergie: " +
        allergieCutaneeRespiratorieSistemiche;
  }
}
