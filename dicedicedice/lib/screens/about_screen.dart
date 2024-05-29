import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 48,
            fontFamily: 'NewRocker',
            color: Colors.orange,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(3.0, 3.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Add elevation to remove AppBar shadow
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background image
          Stack(
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, 50), // Move the image 50 pixels down
                  child: Transform.scale(
                    scale: 1.2, // Adjust the scale factor as needed
                    child: Image.asset(
                      "assets/about.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  const SizedBox(height: 20),
                  // Text content
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ensure column takes minimal vertical space
                      children: [
                        Text(
                          'We are DCube',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Welcome to our app!\nWe are a team of passionate students who came together with a shared goal: to assist indecisive individuals in making choices effortlessly. Fueled by our own experiences of indecision, we embarked on a journey to create a user-friendly and intuitive app that simplifies decision-making processes. Our commitment to innovation and empathy drove us to develop a solution that we believe will make a positive difference in the lives of our users. Join us as we navigate the exciting realm of decision-making together!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutScreen(),
  ));
}
