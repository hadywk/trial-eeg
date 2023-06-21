import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'feedback_instructions.dart';
import 'feedback_screen.dart';
import 'package:graduation/screens/processing_signals_screen.dart';
import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

Random random = new Random();

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

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  void not() async {
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
    await FirebaseFirestore.instance
        .collection('chat')
        .doc((random.nextInt(1000) + 10).toString())
        .set({
      'username': username,
      'text': widget.predicted_result,
      'token': token
    });
  }

  @override
  Widget build(BuildContext context) {
    not();
    var x = 'food';
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Results"),
        centerTitle: true,
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 5, 48, 84),
          Color.fromARGB(255, 134, 8, 50)
        ]),
      ),
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.red,
          Colors.redAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.redAccent,
          Colors.red,
        ],
        child: Center(
          child: Column(
            children: [
              Container(
                child: GestureDetector(
                  child: x == 'food'
                      ? Icon(
                          Icons.food_bank,
                          size: 400,
                          color: Color.fromARGB(255, 5, 48, 84),
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
              Container(
                height: 50,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText(
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                        'Predicted label: ${widget.predicted_result}'),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedbackInstructions()),
                  );
                },
                child: Text(
                  "feedback",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 48, 84),
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
