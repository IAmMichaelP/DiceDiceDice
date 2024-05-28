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
