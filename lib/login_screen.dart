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
  String email = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      icon: Icon(Icons.email_outlined)),
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
                      hintText: 'Enter your password', icon: Icon(Icons.lock)),
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
                  onPressed: () async {
                    print("RESULT: ");
                    try {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        // Navigate to your app's home screen after successful signup
                        print("RESULT: ");
                        print(result);
                        if (result == null) {
                          setState(() {
                            errorMessage = 'Email and password do not match';
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
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ));
  }
}
