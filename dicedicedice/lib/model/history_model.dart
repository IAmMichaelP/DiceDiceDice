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
}
