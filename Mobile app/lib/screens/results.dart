import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'feedback_screen.dart';
import 'package:graduation/screens/processing_signals_screen.dart';

class Results extends StatefulWidget {
  String predicted_result;
  Results({Key? key, required this.predicted_result});
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    //final notificationSettings=await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    var x = 'food';
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: GestureDetector(
                child: x == 'food'
                    ? Icon(
                        Icons.food_bank,
                        size: 400,
                        color: Colors.pink,
                      )
                    : Icon(
                        Icons.local_drink,
                        size: 400,
                        color: Colors.pink,
                      ),
                onTap: () {
                  print('Hello');
                  setState(() {
                    x = 'drink';
                  });
                  print(x);
                },
              ), // <---- Use
            ),
            SizedBox(height: 20),
            Text('Predicted label: ${widget.predicted_result}'),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Feedback_screen()),
                  );
                },
                child: Text("feedback"))
          ],
        ),
      ),
    );
  }
}
