import 'package:flutter/material.dart';

String space = " ";
String aCapo = "\n";
String colon = ":";

List<String> functionalities = [
  "Dati",
  "Badge",
  "Carta d'Identità Salvavita",
  "Braccialetto"
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
  Icon(Icons.qr_code_rounded),
];
