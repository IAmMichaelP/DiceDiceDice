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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Your Throw History',
      //   style: TextStyle(
      //       color: Colors.white, 
      //       fontSize: 20, 
      //       fontWeight: FontWeight.bold,
      //       fontFamily: "Brawler"
      //     ),),
      //     // backgroundColor: const Color.fromARGB(255, 9, 24, 37),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('hist_bg.jpg'), // Set background image
            fit: BoxFit.cover,
          ),
        ),
      child: FutureBuilder<List<HistoryModel>>(
        future: databaseService.getHistoryWithSameUid(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No history found for UID $uid'));
          } else {
            List<HistoryModel> historyList = snapshot.data!;
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                HistoryModel history = historyList[index];
                return Container(
                   decoration:const  BoxDecoration(
                    color: Color.fromRGBO(38, 50, 20, 1),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 9, 22, 7),
                        width: 1.0) ) ),
                    child: ListTile(
                      title: Text(
                        'Decision: ${history.question}',
                        style: const TextStyle(
                          color: Color.fromRGBO(173, 102, 38, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                      ),),
                  subtitle: Text(
                      'Dice Result: ${history.diceResult} \nInterpretation: ${history.interpretation}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 198, 198, 198), // Set subtitle font color
                        fontSize: 14, // Set subtitle font size
                      ),),
                  trailing: Text(history.timeStamp.toDate().toString(),
                  style: const TextStyle(
                        color: Color.fromARGB(255, 99, 98, 98), // Set trailing font color
                        fontSize: 12, // Set trailing font size
                      ),),
                ));
              },
            );
          }
        },
      ),
    ),);
  }
}
