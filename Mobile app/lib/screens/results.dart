import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final email = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()!['email']);

    final username = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()!['username']);

    final token = await FirebaseFirestore.instance
        .collection('tokens')
        .doc(email)
        .get()
        .then((value) => value.data()!['token']);

    fcm.subscribeToTopic('chat');

    await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'username': username,
      'text': widget.predicted_result,
      'token': token
    });
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
