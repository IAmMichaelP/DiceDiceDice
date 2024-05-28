import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
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
            children: [
              // const SizedBox(height: 50),
              Container(
                height: MediaQuery.of(context).size.height,
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
                    Image.asset('subtext.png'),
                    // const Text(
                    //   "DiceDiceDice",
                    //   style: TextStyle(
                    //       fontSize: 30,
                    //       fontFamily: 'NewRocker',
                    //       color: Color(0xFFE73C3C)),
                    // ),
                    const SizedBox(height: 50),
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),

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
                      decoration: const InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Password required";
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
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            // Navigate to your app's home screen after successful signup
                            if (result == null) {
                              setState(() {
                                errorMessage =
                                    'Email and password do not match';
                              });
                            }
                          }
                        } catch (e) {
                          setState(() {
                            errorMessage = 'Email and password do not match';
                          });
                          print(e);
                        }
                      },
                      child: Text('Login'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Don\'t have an account? '),
                          GestureDetector(
                            child: const Text(
                              'Register now',
                              style: TextStyle(color: Color(0xFF3498DB)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()),
                              );
                            },
                          ),
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
