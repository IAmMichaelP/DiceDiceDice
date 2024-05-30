import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';
import '../model/history_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  // Firestore collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference userHistoryCollection =
      FirebaseFirestore.instance.collection('userHistory');

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

  // setting user history every time a new query is added
  Future<UserModel?> setUserHistory(String question, int diceResult,
      String interpretation, Timestamp timeStamp, String dice) async {
    try {
      await userHistoryCollection.add({
        'uid': uid,
        'question': question,
        'diceResult': diceResult,
        'interpretation': interpretation,
        'timeStamp': timeStamp,
        'dice': dice
      });
    } catch (e) {
      print('Error setting user history: $e');
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

  // Convert QuerySnapshot to a list of HistoryModel
  List<HistoryModel> _historyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      try {
        return HistoryModel.fromDocument(doc);
      } catch (e) {
        print('Error converting document to HistoryModel: $e');
        return HistoryModel(
          uid: '',
          question: '',
          diceResult: 0,
          interpretation: '',
          timeStamp: Timestamp.now(),
          dice: '',
        ); // Return a default or empty HistoryModel on error
      }
    }).toList();
  }

  // Method to get history documents with a specific uid
  Future<List<HistoryModel>> getHistoryWithSameUid(String uid) async {
    try {
      QuerySnapshot snapshot =
          await userHistoryCollection.where('uid', isEqualTo: uid).get();
      return _historyListFromSnapshot(snapshot);
    } catch (e) {
      print('Error fetching history with uid $uid: $e');
      return []; // Return an empty list on error
    }
  }
}
