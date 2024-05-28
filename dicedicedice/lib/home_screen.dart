import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
        child: Align(
          alignment: Alignment.topCenter,
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
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      return AnimatedBuilder(
                        animation:
                            animation, // Animation for the Hero transition
                        builder: (context, child) {
                          return ClipOval(
                            clipper: _OvalClipper(animation
                                .value), // Apply clipping based on animation value
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/logo.png', // Image for the transition animation
                          width: 100,
                          height: 100,
                        ),
                      );
                    },
                    child: Image.asset('assets/logo.png',
                        width: 100, height: 100)),
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

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: 'tag',
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
            return AnimatedBuilder(
              animation: animation, // Animation for the Hero transition
              builder: (context, child) {
                return ClipOval(
                  clipper: _OvalClipper(animation
                      .value), // Apply clipping based on animation value
                  child: child,
                );
              },
              child: Image.asset(
                'assets/logo.png', // Image for the transition animation
                width: 100,
                height: 100,
              ),
            );
          },
          child: Image.asset(
            'assets/logo.png', // Image for the transition animation
            width: 200,
            height: 200,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.remove),
      ),
    );
  }
}

class _OvalClipper extends CustomClipper<Rect> {
  final double progress; // Progress of the animation

  _OvalClipper(this.progress);

  @override
  Rect getClip(Size size) {
    final double offset = size.width *
        0.5 *
        progress; // Calculate offset based on animation progress
    return Rect.fromLTRB(
      -offset,
      -offset,
      size.width + offset,
      size.height + offset,
    ); // Define the clipping rectangle
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) =>
      true; // Always reclip for changes
}
