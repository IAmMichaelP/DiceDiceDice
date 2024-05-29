import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'signup_screen.dart';
import 'package:dicedicedice/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            children: [
              // const SizedBox(height: 50),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    // color: Colors.white,
                    // borderRadius: BorderRadiusDirectional.circular(250)
                    image:DecorationImage(
                      image: AssetImage('assets/img2.png'),
                      fit: BoxFit.cover,)
                    ),
                //Mask Overlay
                // Positioned.fill(
                //   child: Container(
                //     color: COlors.black.withOpacity(0.5),
                //   ),),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    // Image.asset('logo.png'),
                    const SizedBox(height: 10),
                    // Image.asset('dice.png'), 
                    const Text(
                      "DICE-CISION",
                      style: TextStyle(
                        fontSize: 55,
                        fontFamily: 'NewRocker',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(248, 122, 4, 1), 
                        // foreground:  Paint()
                        // ..style = PaintingStyle.stroke
                        // ..strokeWidth = 1
                        // ..color = Color.fromARGB(255, 75, 1, 18),
                        // decorationColor: Color(0xFF9A6738),
                      ),
                    ),
                    
                    // const SizedBox(height: 5),
                    const Text(
                      "LET THE DICE DECIDE",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'NewRocker',
                          color: Color.fromARGB(255, 219, 2, 2)),
                    ),
                  const SizedBox(height: 50),
                   const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'NewRocker',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC36036), // Fill color
                  ),
                ),
                    const SizedBox(height: 20),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
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
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 152, 151, 151)),
                          prefixIcon: Icon(Icons.lock, color: const Color.fromRGBO(177, 113, 16, 1)),
                          filled: true,
                          fillColor: Color.fromRGBO(38, 50, 20, 1),
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

                    const SizedBox(height: 15),
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
                        foregroundColor: const Color.fromRGBO(255, 121, 1, 1),
                        backgroundColor: Color.fromRGBO(22, 19, 18, 1),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 55),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)
                          ),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            dynamic result =
                                await _auth.signIn(email, password);
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
                          const Text('Don\'t have an account? ', style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                color: Color.fromARGB(255, 240, 129, 60),
                                fontWeight:FontWeight.bold,),
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
