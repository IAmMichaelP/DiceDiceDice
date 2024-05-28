import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    timeDilation = 5.0;

    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: Text("User"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text('Welcome to the Home Screen!'),
              CircleAvatar(
                backgroundImage: const AssetImage('prof.png'),
                minRadius: MediaQuery.of(context).size.width * 0.5,
              ),
              Center(
                child: Hero(
                  tag: 'tag',
                  child: Image.asset(
                    'assets/logo.png', // Image for the transition animation
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyWidget2()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  _MyWidget2State createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  final Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;
  final List<String> images = [
    'd20/1d20.png',
    'd20/2d20.png',
    'd20/3d20.png',
    'd20/4d20.png',
    'd20/5d20.png',
    'd20/6d20.png',
    'd20/7d20.png',
    'd20/8d20.png',
    'd20/9d20.png',
    'd20/10d20.png',
    'd20/11d20.png',
    'd20/12d20.png',
    'd20/13d20.png',
    'd20/14d20.png',
    'd20/15d20.png',
    'd20/16d20.png',
    'd20/17d20.png',
    'd20/18d20.png',
    'd20/19d20.png',
    'd20/20d20.png',
  ];
  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: random.nextDouble() * 180,
              child: Image.asset(
                images[currentImageIndex],
                height: 100,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                // Sound

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
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Roll',
                  style: TextStyle(fontSize: 26),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.remove),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
