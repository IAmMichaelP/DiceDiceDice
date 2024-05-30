import 'dart:async';
import 'package:dicedicedice/screens/home%20subpages/history_bar.dart';
import 'package:dicedicedice/screens/home%20subpages/home_bar.dart';
import 'package:dicedicedice/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/auth_service.dart';
import 'about_screen.dart';
import '../model/user_model.dart';
import '../service/database_service.dart';

class HomeScreen extends StatelessWidget {
  final String uid;

  HomeScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final String? uid = authService.uid;
    final databaseService = DatabaseService(uid: uid);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF181415),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF181415),
          automaticallyImplyLeading: false,
          title: StreamBuilder<UserModel>(
            stream: databaseService.userData,
            builder: (context, snapshot) {
              UserModel? userData = snapshot.data;

              if (userData == null) {
                return CircularProgressIndicator();
              }

              return Text(
                userData.username,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'NewRocker',
                  color: Color(0xFFF6D5B7),
                ),
              );
            },
          ),
          bottom: const TabBar(
            labelColor: Color(0xFFF6D5B7),
            indicatorColor: Color(0xFFF6D5B7),
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'History'),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 254, 214, 154),
              ),
              color: const Color.fromRGBO(38, 50, 20, 1),
              onSelected: (String value) {
                if (value == 'about') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                } else if (value == 'logout') {
                  authService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'about',
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Color.fromARGB(255, 248, 227, 197),
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(
                        color: Color.fromARGB(255, 198, 181, 181),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 248, 227, 197),
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Color.fromARGB(255, 198, 181, 181),
                      ),
                    ),
                    onTap: () {
                      authService.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/img1.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  TabBarView(
                    children: <Widget>[
                      HomeBar(uid: uid!),
                      HistoryBar(uid: uid!),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
