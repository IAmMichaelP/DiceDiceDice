import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  // Firestore collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> setUserData(String username) async {
    try {
      await userDataCollection.doc(uid).set({
        'uid': uid, // Ensure 'uid' is also stored in the document
        'username': username,
      });
    } catch (e) {
      print('Error setting user data: $e');
      rethrow;
    }
  }

  // Convert QuerySnapshot to a list of UserModel
  List<UserModel> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      try {
        return UserModel(
          uid: doc.get('uid') as String? ?? '',
          username: doc.get('username') as String? ?? '',
        );
      } catch (e) {
        print('Error converting document to UserModel: $e');
        return UserModel(
            uid: '',
            username: ''); // Return a default or empty UserModel on error
      }
    }).toList();
  }

  // Convert DocumentSnapshot to UserModel
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return UserModel(
        uid: snapshot.get('uid') as String? ?? '',
        username: snapshot.get('username') as String? ?? '',
      );
    } catch (e) {
      print('Error converting document to UserModel: $e');
      return UserModel(
          uid: uid!,
          username: ''); // Return a default or empty UserModel on error
    }
  }

  // Stream of list of UserModel
  Stream<List<UserModel>> get userDataList {
    return userDataCollection.snapshots().map(_userDataListFromSnapshot);
  }

  // Stream of single UserModel
  Stream<UserModel> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
