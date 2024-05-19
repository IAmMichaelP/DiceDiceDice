import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                decoration: InputDecoration(hintText: 'Enter your email'),
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
                decoration: InputDecoration(hintText: 'Enter your password'),
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
                  try {
                    if (_formKey.currentState!.validate()) {
                      dynamic result =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
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
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
