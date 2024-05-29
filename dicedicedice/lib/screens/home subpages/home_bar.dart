import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../service/database_service.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeBar extends StatelessWidget {
//   // const HomeBar({super.key});
//   // final UserModel userData = UserModel();
//   final _myWidgetKey = GlobalKey<_MyWidget2State>();
//   final String uid;

//   HomeBar({required this.uid});

//   @override
//   Widget build(BuildContext context) {
//     return HomeBar();
//   }
// }

class HomeBar extends StatefulWidget {
  final String uid;
  HomeBar({required this.uid});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  List<String> interpretationList = [
    'very negative',
    'negative',
    'positive',
    'very positive'
  ];
  final Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;

  void rollDice() {
    // Roll the dice
    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      setState(() {
        currentImageIndex = random.nextInt(20);
      });

      if (counter >= 13) {
        timer.cancel();
        setState(() {
          counter = 1;
        });
      }
    });
  }

  final List<String> images = [
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
  final List<String> dice_all = [
    'assets/d4.png',
    'assets/d6.png',
    'assets/d8.png',
    'assets/d10.png',
    'assets/d12.png',
    'assets/d20.png',
  ];
  List<String> currentDiceImages = [];
  String currentDiceType = 'd20';
  final AudioPlayer player = AudioPlayer();

  String question = '';
  int diceResult = 0;
  String interpretation = '';
  Timestamp timeStamp = Timestamp.now();
  String dice = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final GlobalKey<_HomeBarState> _myWidgetKey = GlobalKey<_HomeBarState>();
    final authService = Provider.of<AuthService>(context);
    final String? uid = authService.uid;
    final databaseService = DatabaseService(uid: uid);

    void saveQuestion() async {
      // diceResult = _myWidgetKey.currentState!.currentImageIndex;
      print("dice result: $diceResult");
      dice = 'd20';
      print("dice result: $dice");
      interpretation = interpretationList[diceResult ~/ 4];
      print("interpretation result: $interpretation");
      print("timestamp result: $timeStamp");
      dynamic result = await databaseService.setUserHistory(
          question, diceResult, interpretation, timeStamp, dice);
      print(result);
      print('history');
    }

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/Dice-cider.png'),
            const SizedBox(height: 10),
            Image.asset('assets/subtitle.png'),
            const SizedBox(height: 30),
            Transform.rotate(
              angle: random.nextDouble() * 180,
              child: Image.asset(
                images[currentImageIndex],
                height: 100,
              ),
            ),
            const SizedBox(height: 30),
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
                          borderRadius:
                              BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)), 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: 
                            BorderRadius.circular(12.0), 
                            borderSide: BorderSide(color: Color.fromARGB(255, 143, 94, 11)), // Border radius when focused
                        ),
                        hintText: 'Enter your indecisiveness here',
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 55, 44, 44),
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
                    // const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // Rolling the dice

                        // Sound
                        // await player.setAsset('assets/audios/rolling-dice.mp3');
                        // player.play();

                        // Roll the dice
                        Timer.periodic(const Duration(milliseconds: 80),
                            (timer) {
                          counter++;
                          setState(() {
                            currentImageIndex = random.nextInt(images.length);
                          });

                          if (counter >= 13) {
                            timer.cancel();

                            setState(() {
                              counter = 1;
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.7, 55),
                        side: const BorderSide(
                            color: Color(0xFF8C5E33), width: 2.0),
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
                    const SizedBox(height: 30),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: dice_all.map((diceImage) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentImageIndex = dice_all.indexOf(diceImage);
                              // Colors.blue; change bg color each contnr
                            }); //change lang laterrr
                          },
                          child: Container(height: 75,
                          decoration: const BoxDecoration(
                          // color: Colors.blue, 
                          // borderRadius: BorderRadius.circular(8.0), 
                          ),
                          padding: EdgeInsets.all(8.0), 
                          child: Image.asset(
                            diceImage,
                            height: 75,    ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

// class MyWidget2 extends StatefulWidget {
//   MyWidget2({super.key});

//   @override
//   _MyWidget2State createState() => _MyWidget2State();
// }

// class _MyWidget2State extends State<MyWidget2> {
//   final Random random = Random();
//   int currentImageIndex = 0;
//   int counter = 1;

//   void rollDice() {
//     // Roll the dice
//     Timer.periodic(const Duration(milliseconds: 80), (timer) {
//       counter++;
//       setState(() {
//         currentImageIndex = random.nextInt(20);
//       });

//       if (counter >= 13) {
//         timer.cancel();
//         setState(() {
//           counter = 1;
//         });
//       }
//     });
//   }

//   final List<String> images = [
//     'd20/1d20.png',
//     'd20/2d20.png',
//     'd20/3d20.png',
//     'd20/4d20.png',
//     'd20/5d20.png',
//     'd20/6d20.png',
//     'd20/7d20.png',
//     'd20/8d20.png',
//     'd20/9d20.png',
//     'd20/10d20.png',
//     'd20/11d20.png',
//     'd20/12d20.png',
//     'd20/13d20.png',
//     'd20/14d20.png',
//     'd20/15d20.png',
//     'd20/16d20.png',
//     'd20/17d20.png',
//     'd20/18d20.png',
//     'd20/19d20.png',
//     'd20/20d20.png',
//   ];
//   final AudioPlayer player = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     timeDilation = 5.0;

//     return Align(
//       alignment: Alignment.topCenter,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Transform.rotate(
//             angle: random.nextDouble() * 180,
//             child: Image.asset(
//               images[currentImageIndex],
//               height: 100,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
// }
