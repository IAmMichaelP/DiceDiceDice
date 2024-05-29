import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:dicedicedice/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/login_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Title
                      Stack(
                        children: [
                          // Outline text
                          Text(
                            'DICE-CIDER',
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'NewRocker',
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 10
                                ..color = Color(0xFF4B0112), // Outline color
                            ),
                          ),
                          Text(
                            'DICE-CIDER',
                            style: TextStyle(
                              fontFamily: 'NewRocker',
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD66B05),
                            ),
                          ),
                        ],
                      ),
                      // Subtitle
                      Text(
                        'Let the dice decide',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NewRocker',
                          fontSize: 25,
                          color: Color(0xFFC36036),
                          shadows:[Shadow(color: Colors.black, // Choose the color of the shadow.
                          blurRadius: 2.0, // Adjust the blur radius for the shadow effect.
                          offset: Offset(2.0, 2.0),),],),
                      ),
                      const SizedBox(height: 30),
                      // Email input
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Email required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Password input
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler'),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.lock, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Password required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // Error message
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Login button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF161312),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: BorderSide(color: Color(0xFFFF7901), width: 2.0),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.signIn(email, password);
                            if (result == null) {
                              setState(() {
                                errorMessage = 'Email and password do not match';
                              });
                            }
                          }
                        },
                        child: Text('Log In', style: TextStyle(color: Color(0xFFFF7901)),),
                      ),
                      const SizedBox(height: 20),
                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member? ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: Text(
                              'Create an Account',
                              style: TextStyle(color: Color(0xFFFF7901), fontWeight: FontWeight.bold,
    shadows:[Shadow(color: Colors.black, // Choose the color of the shadow.
    blurRadius: 2.0, // Adjust the blur radius for the shadow effect.
    offset: Offset(2.0, 2.0),),],),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
