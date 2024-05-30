import 'package:flutter/material.dart';
import '../../service/database_service.dart';
import '../../model/history_model.dart';

class HistoryBar extends StatelessWidget {
  final String uid;

  HistoryBar({required this.uid});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService(uid: uid);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Your Throw History'),
      ),
      body: FutureBuilder<List<HistoryModel>>(
        future: databaseService.getHistoryWithSameUid(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Empty'));
          } else {
            List<HistoryModel> historyList = snapshot.data!;
            // Sort historyList by timeStamp
            historyList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                HistoryModel history = historyList[index];
                return ListTile(
                  title: Text('Question: ${history.question}'),
                  subtitle: Text(
                      'Dice: ${history.dice}, Dice Result: ${history.diceResult}, Interpretation: ${history.interpretation}'),
                  trailing: Text(history.timeStamp.toDate().toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
