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

  Map<String, String> toMapPSSSectionZero() {
    return {
      'Nome': nome + " " + cognome,
      'Codice fiscale': cf,
      'Numero carta d\'idendità': numeroCartaIdentita,
      'Sesso': sesso,
      'Data di nascita': dataNascita,
      'Comune di nascita': comuneNascita,
      'Provincia di nascita': provinciaNascita,
      'Indirizzo di domicilio': indirizzoDomicilio,
      'Comune di domicilio': comuneDomicilio,
      'Provincia di domicilio': provinciaDomicilio,
      'CAP': cap,
      'Email': email,
      'Telefono': telefono,
      'Pec': pec
    };
  }

  Map<String, String> toMapPSSSectionOne() {
    return {
      'Codici di esenzione': codiceEsenzione,
      'Reti di patologie': retiPatologieAssistito,
      'Capacità motoria': capacitaMotoriaAssistito,
      'Attività lavorativa': attivitaLavorativa,
      'Patologie croniche': fromListToString(patologieCronicheRilevanti),
      'Organi mancanti': organiMancanti,
      'Trapianti': trapianti,
      'Rilevanti malformazioni': rilevantiMalformazioni,
    };
  }

  Map<String, String> toMapPSSSectionTwo() {
    return {
      'Reazioni avverse a farmaci e/o alimenti': reazioniAvverseFarmaciAlimenti,
      'Allergie cutanee, respiratorie e sistemiche':
          allergieCutaneeRespiratorieSistemiche,
      'Allergie a veleno di imenotteri': allergieVelenoImenotteri,
      'Terapie farmacologiche croniche': terapieFarmacologicheCroniche,
      'Anamnesi famigliari': anamnesiFamigliari,
      'Terapie farmacologiche': terapieFarmacologiche,
      'Fattori di rischio': fattoriRischio,
      'Protesi': protesi,
      'Ausili': ausili,
      'Vaccinazioni': vaccinazioni,
    };
  }

  Map<String, String> toMapPSSSectionThree() {
    return {
      'Contatto di emergenza 1': contatto1 + " - " + telefono1,
      'Contatto di emergenza 2': contatto2 + " - " + telefono2,
      'Contatto caregiver': contattoCareGiver + " - " + telefonoCareGiver,
      'Donazione organi': donazioneOrgani,
      'Gravidanze e parti': gravidanzeParti,
      'Patologie croniche rilevanti':
          fromListToString(patologieCronicheRilevanti),
    };
  }

  Map<String, String> toMapPSSSectionFour() {
    return {
      'Altezza': altezza,
      'Peso': peso,
      'Pressione arteriosa': pressioneArteriosa,
      'BMI': bmi,
      'Assistenza domiciliare integrata (ADI)': adi,
      'Assistenza domiciliare programmata (ADP)': adp,
      'Gruppo sanguigno': gruppoSanguigno + fattoreRH,
      'Codice ATS': codiceATS,
      'Area utenza': areaUtenza,
      'Comune di rilascio': comuneRilascio,
      'Data di scadenza': dataScadenza,
      'Patologie in atto': fromListToString(patologieInAtto),
      'Servizio o associazione': servizioAssociazione,
      'viveSolo': viveSolo
    };
  }

  Map<String, String> toMapIta() {
    return {
      'Nome': nome + " " + cognome,
      'Data di nascita': dataNascita,
      'Gruppo sanguigno': gruppoSanguigno + fattoreRH,
      'Contatto ICE1': contatto1 + "-" + telefono1,
      'Contatto ICE2': contatto2 + "-" + telefono2,
      'Allergie': allergieCutaneeRespiratorieSistemiche,
      'Patologie in atto:': fromListToString(patologieInAtto),
      'Patologie croniche': fromListToString(patologieCronicheRilevanti),
      'Terapie': terapieFarmacologicheCroniche
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
        "Allergie: " +
        allergieCutaneeRespiratorieSistemiche +
        aCapo +
        "Patologie in atto: " +
        fromListToString(patologieInAtto) +
        aCapo +
        "Patologie croniche: " +
        fromListToString(patologieCronicheRilevanti) +
        aCapo +
        "Terapie: " +
        terapieFarmacologicheCroniche;
  }
}
