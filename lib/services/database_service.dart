import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis/services/auth_service.dart';

class DatabaseService {
  AuthService _auth = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference usersProva =
      FirebaseFirestore.instance.collection('usersProva');

  Future<String> getProva() async {
    String id;
    await usersProva
        .doc("pO6ksQ1V3xQtuzcjaJIA")
        .get()
        .then((value) => id = value["id"]);
    return id;
  }

  Future<bool> isUser() async {
    bool isUser;
    await users
        .doc(_auth.getCurrentUser().uid)
        .get()
        .then((value) => isUser = value["user"]);
    return isUser;
  }
}
