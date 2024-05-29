import 'service/firebase_options.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        StreamProvider<User?>(
          create: (context) => context.read<AuthService>().currentUser,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            return Consumer<User?>(
              builder: (context, user, _) {
                if (user == null) {
                  return WelcomeScreen();
                } else {
                  // Navigate to the HomeScreen with the user's uid as an argument
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: user.uid,
                    );
                  });
                  return Container(); // or any other placeholder widget
                }
              },
            );
          },
        ),
        routes: {
          '/signup': (context) => SignupScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(
              uid: ModalRoute.of(context)?.settings.arguments as String),
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AuthService(),
//       child: MaterialApp(
//         title: 'Flutter Firebase Auth',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Consumer<AuthService>(
//           builder: (context, auth, _) {
//             return auth.user == null ? WelcomeScreen() : HomeScreen();
//           },
//         ),
//         routes: {
//           '/signup': (context) => SignupScreen(),
//           '/login': (context) => LoginScreen(),
//           '/home': (context) => HomeScreen()
//         },
//       ),
//     );
//   }
// }
