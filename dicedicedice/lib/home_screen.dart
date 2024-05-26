import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
