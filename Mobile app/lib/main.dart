import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graduation/screens/form_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation/screens/home_screen.dart';
import 'package:graduation/screens/feedback_screen2.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    //final notificationSettings=await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
    fcm.subscribeToTopic('chat');

    final email = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()!['care_giver_email']);

    await FirebaseFirestore.instance
        .collection('tokens')
        .doc(email)
        .set({'token': token});
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              setupPushNotification();
              return const HomePage();
            }
            return const FormScreen();
          }),
    );
  }
}
