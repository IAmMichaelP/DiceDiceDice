import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../service/database_service.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';

class HomeBar extends StatelessWidget {
  // const HomeBar({super.key});
  // final UserModel userData = UserModel();
  final String uid;

  HomeBar({required this.uid});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final String? uid = authService.uid;
    final databaseService = DatabaseService(uid: uid);

    String question = '';

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('Dice-cider.png'),
            const SizedBox(height: 10),
            Image.asset('subtitle.png'),

            const SizedBox(height: 50),
            Form(
                child: Column(
              children: [
                TextFormField(
                  maxLines: 5,

                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9),
                    filled: true,
                    fillColor: Color(0xFF8C5E33), // Background color
                    // labelText: 'Enter your text',
                    // labelStyle:
                    //     TextStyle(color: Color(0xFF8C5E33)), // Label text color
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //     color: Colors.blue,
                      //     width: 2.0), // Border color and width
                      borderRadius:
                          BorderRadius.circular(12.0), // Border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //     color: Colors.green,
                      //     width: 2.0), // Border color and width when focused
                      borderRadius: BorderRadius.circular(
                          5.0), // Border radius when focused
                    ),
                    hintText: 'Enter a question here',
                    // hintStyle:
                    //     TextStyle(color: Colors.blueGrey), // Hint text color
                  ),
                  style: TextStyle(color: Colors.black), // Text color
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Roll A Dice'),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 55),
                    side:
                        const BorderSide(color: Color(0xFF8C5E33), width: 2.0),
                    backgroundColor: Color(0xFF161312), // Button color
                    foregroundColor: Color(0xFF8C5E33), // Text color
                  ),
                ),
              ],
            ))

            // ElevatedButton(onPressed: () =>
            // Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => AddChoicesScreen()),
            //               ), child: Text("Add Choices")),
            // ElevatedButton(onPressed: () =>
            // Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ChooseDice()),
            //               ), child: Text("Choose Dice")),
          ],
        ),
      ),
    );
  }
}
