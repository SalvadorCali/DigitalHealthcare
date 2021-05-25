import 'package:flutter/material.dart';

String datiSalvavita = "DATI SALVAVITA";
String space = " ";
String aCapo = "\n";
String colon = ":";
String cittadino = "cittadino";
String volontario = "volontario";
String medico = "medico";

List<Image> images = [
  Image.asset("assets/images/summary.png"),
  Image.asset("assets/images/badge.png"),
  Image.asset("assets/images/cis.png"),
  Image.asset("assets/images/bracelet.png"),
];

List<String> functionalities = ["Dati", "Badge", "CIS", "Braccialetto"];

List<String> subtitles = [
  "Profilo Sanitario Sintetico",
  "Badge Salvavita",
  "Carta d'Identità Salvavita",
  "Braccialetto Salvavita"
];

List<String> descriptions = [
  "Il Profilo Sanitario Sintetico è il documento sanitario che riassume la storia clinica del paziente e la sua situazione corrente. Tale documento è creato ed aggiornato dal medico di famiglia.",
  "Il badge, rappresenta la facciata destra della C.I.S e contiene un QR code che contiene tutte le informazioni salvavita. Il QR può essere letto dal soccorritore con il suo cellulare.",
  "La C.I.S. è un tesserino cartaceo che riporta in chiaro sulla facciata interna sinistra i tuoi dati anagrafici, i numeri di telefono da chiamare in caso di emergenza e i dati salvavita.",
  "Il Braccialetto Salvavita contiene il QR code e che segnala ai soccorritori che la persona che lo porta è dotata di una Carta d'Identità Salvavita."
];

List<Icon> icons = [
  Icon(Icons.person),
  Icon(Icons.badge),
  Icon(Icons.portrait),
  Icon(Icons.calendar_view_day),
];

String fromMillisecondsToDate(String date) {
  int dateInt = int.parse(date);
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateInt);
  return formatDate(dateTime);
}

String formatDate(DateTime date) {
  return date.day.toString() +
      " " +
      _getMonth(date.month) +
      " " +
      date.year.toString();
}

String _getMonth(int month) {
  switch (month) {
    case 1:
      return "Gennaio";
    case 2:
      return "Febbraio";
    case 3:
      return "Marzo";
    case 4:
      return "Aprile";
    case 5:
      return "Maggio";
    case 6:
      return "Giugno";
    case 7:
      return "Luglio";
    case 8:
      return "Agosto";
    case 9:
      return "Settembre";
    case 10:
      return "Ottobre";
    case 11:
      return "Novembre";
    case 12:
      return "Dicembre";
    default:
      return "";
  }
}
