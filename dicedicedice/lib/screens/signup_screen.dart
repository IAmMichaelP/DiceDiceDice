import 'package:dicedicedice/screens/login_screen.dart';
import 'package:flutter/material.dart';
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
                          color: Color(0xFFC36036), shadows:[Shadow(color: Colors.black, // Choose the color of the shadow.
                          blurRadius: 2.0, // Adjust the blur radius for the shadow effect.
                          offset: Offset(2.0, 2.0),),],),
                        ),
                      const SizedBox(height: 25),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler'),
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Brawler'),
                          prefixIcon: Icon(Icons.person_outlined, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Username required";
                          }
                          return null; // Added return null
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Brawler'),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Email required";
                          }
                          return null; // Added return null
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler'),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Brawler'),
                          prefixIcon: Icon(Icons.lock, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Password required";
                          }
                          return null; // Added return null
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontFamily: 'Brawler', fontSize: 17),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Re-enter your password',
                          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Brawler'),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.orange),
                          filled: true,
                          fillColor: Color(0xFF263214).withOpacity(.90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Repeat password required";
                          }
                          if (value != password) {
                            return "Repeat password didn't match";
                          }
                          return null; // Added return null
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
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          backgroundColor: Color(0xFF161312),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: BorderSide(color: Color(0xFFFF7901), width: 2.0),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              dynamic result = await _auth.signUp(email, password, username);
                              if (result == null) {
                                setState(() {
                                  errorMessage = 'Register valid credentials';
                                });
                              } else {
                                Navigator.pushNamed(context, '/home');
                              }
                            } catch (e) {
                              setState(() {
                                errorMessage = 'Email and password do not match';
                              });
                              print(e);
                            }
                          }
                        },
                        child: const Text('Sign Up', style: TextStyle(color: Color(0xFFFF7901), fontSize: 18),),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Already have an account? ', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Brawler'),),
                          GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Color(0xFFFF7901), fontWeight: FontWeight.bold, fontFamily: 'Brawler',
                                  shadows:[Shadow(color: Colors.black, // Choose the color of the shadow.
    blurRadius: 2.0, // Adjust the blur radius for the shadow effect.
    offset: Offset(2.0, 2.0),)]),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
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
