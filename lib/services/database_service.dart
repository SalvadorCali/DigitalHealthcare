import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/end_user.dart';
import 'package:thesis/model/patient.dart';
import 'package:thesis/model/timestamp_patient.dart';
import 'package:thesis/services/auth_service.dart';

class DatabaseService {
  AuthService _auth = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('citizens');

  Future<EndUser> getUser() {
    return users
        .doc(_auth.getCurrentUser().uid)
        .get()
        .then((value) => _userFromFirebase(value));
  }

  EndUser _userFromFirebase(DocumentSnapshot snapshot) {
    return EndUser(
        id: snapshot.data()['id'],
        tin: snapshot.data()['tin'],
        email: snapshot.data()['email'],
        isUser: snapshot.data()['user']);
  }

  Future<Patient> getPatient(String tin) async {
    String name;
    String surname;
    print(tin);
    await patients
        .doc(tin)
        .get()
        .then((value) => {name = value["name"], surname = value["surname"]});
    print(name);
    return patients.doc(tin).collection('data').get().then((value) {
      print("qua");
      return Patient(tin, name, surname, _patientFromFirebase(value));
    });
  }

  Map<String, TimestampPatient> _patientFromFirebase(QuerySnapshot snapshot) {
    print("qui");
    Map<String, TimestampPatient> data = Map();
    TimestampPatient patient = createPatient();
    snapshot.docs.forEach((element) {
      data.addAll({fromMillisecondsToDate(element.id): patient});
      patient = createPatientWithName("Piero", "Fasulli");
      print("provina");
    });
    print(data);
    return data;
  }

  Future<List<Patient>> getPatientsList(String tin) {
    Map<String, TimestampPatient> map = Map();
    return patients.where("volunteer_tin", isEqualTo: tin).get().then((value) =>
        value.docs
            .map((e) => Patient(e.id, e["name"], e["surname"], map))
            .toList());
  }

  populatePatientsData(List<Patient> patientsList) {
    patientsList.forEach((element) {
      patients.doc(element.tin).collection("data").get().then((value) {
        element.data = _patientFromFirebase(value);
      });
    });
  }
}
