import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  String uid;
  String question;
  int diceResult;
  String interpretation;
  Timestamp timeStamp;
  String dice;

  HistoryModel(
      {required this.uid,
      required this.question,
      required this.diceResult,
      required this.interpretation,
      required this.timeStamp,
      required this.dice});

  // Factory method to create a HistoryModel from a Firestore document
  factory HistoryModel.fromDocument(DocumentSnapshot doc) {
    return HistoryModel(
      uid: doc.get('uid') as String,
      question: doc.get('question') as String,
      diceResult: doc.get('diceResult') as int,
      interpretation: doc.get('interpretation') as String,
      timeStamp: doc.get('timeStamp') as Timestamp,
      dice: doc.get('dice') as String,
    );
  }
}
