import 'package:flutter/material.dart';
import '../../service/database_service.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeBar extends StatefulWidget {
  final String uid;
  HomeBar({required this.uid});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;
  int diceResult = 0;
  int diceMax = 20;
  String diceType = 'd20';
  List<String> currentDiceImages = [];
  String question = '';
  String interpretation = '';
  Timestamp timeStamp = Timestamp.now();
  String dice = '';

  final List<String> d20_images = [
    'assets/d20/1d20.png',
    'assets/d20/2d20.png',
    'assets/d20/3d20.png',
    'assets/d20/4d20.png',
    'assets/d20/5d20.png',
    'assets/d20/6d20.png',
    'assets/d20/7d20.png',
    'assets/d20/8d20.png',
    'assets/d20/9d20.png',
    'assets/d20/10d20.png',
    'assets/d20/11d20.png',
    'assets/d20/12d20.png',
    'assets/d20/13d20.png',
    'assets/d20/14d20.png',
    'assets/d20/15d20.png',
    'assets/d20/16d20.png',
    'assets/d20/17d20.png',
    'assets/d20/18d20.png',
    'assets/d20/19d20.png',
    'assets/d20/20d20.png',
  ];
  final List<String> d12_images = [
    'assets/d12/1d12.png',
    'assets/d12/2d12.png',
    'assets/d12/3d12.png',
    'assets/d12/4d12.png',
    'assets/d12/5d12.png',
    'assets/d12/6d12.png',
    'assets/d12/7d12.png',
    'assets/d12/8d12.png',
    'assets/d12/9d12.png',
    'assets/d12/10d12.png',
    'assets/d12/11d12.png',
    'assets/d12/12d12.png',
  ];
  final List<String> d10_images = [
    'assets/d10/0d10.png',
    'assets/d10/1d10.png',
    'assets/d10/2d10.png',
    'assets/d10/3d10.png',
    'assets/d10/4d10.png',
    'assets/d10/5d10.png',
    'assets/d10/6d10.png',
    'assets/d10/7d10.png',
    'assets/d10/8d10.png',
    'assets/d10/9d10.png',
  ];
  final List<String> d8_images = [
    'assets/d8/1d8.png',
    'assets/d8/2d8.png',
    'assets/d8/3d8.png',
    'assets/d8/4d8.png',
    'assets/d8/5d8.png',
    'assets/d8/6d8.png',
    'assets/d8/7d8.png',
    'assets/d8/8d8.png',
  ];
  final List<String> d6_images = [
    'assets/d6/1d6.png',
    'assets/d6/2d6.png',
    'assets/d6/3d6.png',
    'assets/d6/4d6.png',
    'assets/d6/5d6.png',
    'assets/d6/6d6.png',
  ];
  final List<String> d4_images = [
    'assets/d4/1d4.png',
    'assets/d4/2d4.png',
    'assets/d4/3d4.png',
    'assets/d4/4d4.png',
  ];
  final List<String> dice_all = [
    'assets/d4/4d4.png',
    'assets/d6/6d6.png',
    'assets/d8/8d8.png',
    'assets/d10/9d10.png',
    'assets/d12/12d12.png',
    'assets/d20/20d20.png',
  ];

  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    currentDiceImages = d20_images; // default dice images
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authService = Provider.of<AuthService>(context);
    final String? uid = authService.uid;
    final databaseService = DatabaseService(uid: uid);

    void saveQuestion(BuildContext context) async {
      if (diceResult == 1) {
        interpretation = 'Critical Failure';
      } else if (diceResult == diceMax) {
        interpretation = 'Critical Success';
      } else if (diceResult / diceMax < 0.25) {
        interpretation = 'Very Negative';
      } else if (diceResult / diceMax < 0.5) {
        interpretation = 'Negative';
      } else if (diceResult / diceMax < 0.75) {
        interpretation = 'Positive';
      } else if (diceResult / diceMax < 1) {
        interpretation = 'Very Positive';
      }
      dynamic result = await databaseService.setUserHistory(
          question, diceResult, interpretation, timeStamp, diceType);
      print(result);
      print('history');

      // Show popup with saved data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Question: $question"),
                Text("Dice Result: $diceResult"),
                Text("Interpretation: $interpretation"),
                Text("Dice: $diceType"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    }

    void rollDice() {
      Timer.periodic(const Duration(milliseconds: 80), (timer) {
        counter++;
        setState(() {
          currentImageIndex = random.nextInt(currentDiceImages.length);
        });
        if (counter >= 13) {
          timer.cancel();
          setState(() {
            counter = 1;
            diceResult = currentImageIndex + 1;
            print('dice result: $diceResult');
            saveQuestion(context);
          });
        }
      });
    }

    void updateDiceImages(int index) {
      switch (index) {
        case 0:
          currentDiceImages = d4_images;
          diceType = 'd4';
          diceMax = 4;
          break;
        case 1:
          currentDiceImages = d6_images;
          diceType = 'd6';
          diceMax = 6;
          break;
        case 2:
          currentDiceImages = d8_images;
          diceType = 'd8';
          diceMax = 8;
          break;
        case 3:
          currentDiceImages = d10_images;
          diceType = 'd10';
          diceMax = 10;
          break;
        case 4:
          currentDiceImages = d12_images;
          diceType = 'd12';
          diceMax = 12;
          break;
        case 5:
          currentDiceImages = d20_images;
          diceType = 'd20';
          diceMax = 20;
          break;
      }
    }

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset('assets/Dice-cider.png'),
          const SizedBox(height: 10),
          Image.asset('assets/subtitle.png'),
          const SizedBox(height: 10),
          Transform.rotate(
            angle: random.nextDouble() * 180,
            child: Image.asset(
              currentDiceImages[currentImageIndex],
              height: 100,
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85),
                    filled: true,
                    fillColor: Color(0xFF8C5E33), // Background color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 143, 94, 11)), // Border radius when focused
                    ),
                    hintText: 'Enter your indecisiveness here',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 55, 44, 44),
                        fontFamily: 'Brawler'),
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Brawler'),
                  onChanged: (value) {
                    question = value;
                  },
                  validator: (value) {
                    if (value?.trim().isEmpty ?? false) {
                      return "Please provide indecisiveness";
                    }
                    return null;
                  }, // Text color
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    rollDice();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.7, 55),
                    side:
                        const BorderSide(color: Color(0xFF8C5E33), width: 2.0),
                    backgroundColor: Color(0xFF161312), // Button color
                    foregroundColor: Color(0xFF8C5E33), // Text color
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Roll A Dice',
                      style: TextStyle(
                          fontFamily: 'Brawler',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: dice_all.map((diceImage) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (diceImage == 'assets/d4/4d4.png') {
                            diceType = 'd4';
                            diceMax = 4;
                          } else if (diceImage == 'assets/d6/6d6.png') {
                            diceType = 'd6';
                            diceMax = 6;
                          } else if (diceImage == 'assets/d8/8d8.png') {
                            diceType = 'd8';
                            diceMax = 8;
                          } else if (diceImage == 'assets/d10/9d10.png') {
                            diceType = 'd10';
                            diceMax = 10;
                          } else if (diceImage == 'assets/d12/12d12.png') {
                            diceType = 'd12';
                            diceMax = 12;
                          } else if (diceImage == 'assets/d20/20d20.png') {
                            diceType = 'd20';
                            diceMax = 20;
                          }
                          currentImageIndex = dice_all.indexOf(diceImage);
                          updateDiceImages(currentImageIndex);
                        });
                      },
                      child: Container(
                        height: 75,
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          diceImage,
                          height: 50,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
