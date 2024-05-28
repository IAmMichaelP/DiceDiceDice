import 'package:dicedicedice/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dicedicedice/service/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String errorMessage = '';
  Color mycolor = const Color(0xFF2C3E50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1.3,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(250)),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      // Image.asset('logo.png'),
                      const SizedBox(height: 10),
                      Image.asset('dice.png'), const SizedBox(height: 10),
                      Image.asset('subtext.png'), const SizedBox(height: 50),
                      const Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          username = value;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your username',
                            prefixIcon: Icon(Icons.person_outlined)),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Username required";
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.email_outlined)),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Email required";
                          }
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock)),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Password required";
                          }
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        // onChanged: (value) {
                        //   password = value;
                        // },
                        decoration: const InputDecoration(
                            hintText: 'Re-enter your password',
                            prefixIcon: Icon(Icons.lock_outline)),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Repeat password required";
                          }
                          if (value != password) {
                            return "Repeat password didn't match";
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF3498DB),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 55),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.signUp(email, password, username);
                              // Navigate to your app's home screen after successful signup
                              print(result);
                              if (result == null) {
                                setState(() {
                                  errorMessage = 'Register valid credentials';
                                });
                              }
                              Navigator.pushNamed(
                                context,
                                '/home',
                              );
                            }
                          } catch (e) {
                            setState(() {
                              errorMessage = 'Email and password do not match';
                            });
                            print(e);
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Already have an account? '),
                            GestureDetector(
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Color(0xFF3498DB)),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                            ),
                          ]),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
