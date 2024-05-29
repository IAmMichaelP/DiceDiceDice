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
      // backgroundColor: mycolor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1.3,
                  padding: EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage('assets/img2.png'),
                    fit:BoxFit.cover),),

                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      // Image.asset('logo.png'),
                      const SizedBox(height: 10),
                      // Image.asset('dice.png'), const SizedBox(height: 10),
                      // Image.asset('subtext.png'), const SizedBox(height: 50),
                      const Text(
                      "DICE-CISION",
                      style: TextStyle(
                        fontSize: 55,
                        fontFamily: 'NewRocker',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(224, 109, 2, 1), 
                      ),
                    ),
                    // const SizedBox(height: 5),
                    const Text(
                      "LET THE DICE DECIDE",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'NewRocker',
                          color: Color.fromARGB(255, 202, 4, 4)),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NewRocker',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC36036),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                      style: const TextStyle(color: Colors.white),                   
                        decoration: InputDecoration(
                            hintText: 'Enter your username',
                            hintStyle: const TextStyle(color: Color.fromARGB(255, 152, 151, 151)),
                            prefixIcon: const Icon(Icons.person_outlined,color:  Color.fromRGBO(177, 113, 16, 1)),
                            filled: true,
                        fillColor: const Color.fromRGBO(38, 50, 20, 1),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 22, 1, 1), width: 2.0),
                        ), 
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 115, 29), width: 2.0),
                        ),
                            ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Username required";
                          }
                        },
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: const TextStyle(color: Color.fromARGB(255, 152, 151, 151)),
                            prefixIcon: const Icon(Icons.email_outlined,color: Color.fromRGBO(177, 113, 16, 1)),
                            filled: true,
                        fillColor: const Color.fromRGBO(38, 50, 20, 1),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 22, 1, 1), width: 2.0),
                        ), 
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 115, 29), width: 2.0),
                        ),),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Email required";
                          }
                        },
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: Color.fromARGB(255, 152, 151, 151)),
                            prefixIcon: const Icon(Icons.lock, color:  Color.fromRGBO(177, 113, 16, 1)),
                            filled: true,
                        fillColor: const Color.fromRGBO(38, 50, 20, 1),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 22, 1, 1), width: 2.0),
                        ), 
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 115, 29), width: 2.0),
                        ),),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Password required";
                          }
                        },
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        obscureText: true,
                        // onChanged: (value) {
                        //   password = value;
                        // },
                      style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Re-enter your password',
                            hintStyle:const TextStyle(color: Color.fromARGB(255, 152, 151, 151)),
                            prefixIcon: const Icon(Icons.lock_outline, color:  Color.fromRGBO(177, 113, 16, 1)),
                            filled: true,
                        fillColor: const Color.fromRGBO(38, 50, 20, 1),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 22, 1, 1), width: 2.0),
                        ), 
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 115, 29), width: 2.0),
                        ),),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Repeat password required";
                          }
                          if (value != password) {
                            return "Repeat password didn't match";
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromRGBO(255, 121, 1, 1),
                        backgroundColor: Color.fromRGBO(22, 19, 18, 1),
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
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  '/home',
                                );
                              }
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
                            const Text('Already have an account? ',style: TextStyle(color: Colors.white),),
                            GestureDetector(
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                color: Color.fromARGB(255, 240, 129, 60),
                                fontWeight:FontWeight.bold,)
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
