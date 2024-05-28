import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  Future setUserData(String username) async {
    return await userDataCollection.doc(uid).set({
      'username': username,
    });
  }
}
