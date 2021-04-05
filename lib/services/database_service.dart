import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('usersProva');

  Future<String> getProva() async {
    String id;
    await users
        .doc("pO6ksQ1V3xQtuzcjaJIA")
        .get()
        .then((value) => id = value["id"]);
    return id;
  }
}
