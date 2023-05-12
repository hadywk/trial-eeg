import 'package:appbar_animated/appbar_animated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'processing_signals_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    //final notificationSettings=await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
    fcm.subscribeToTopic('chat');
  }

  void signalsScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ProcessingSignals();
        },
      ),
    );
  }

  @override
  initstate() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar:
            const ColorBuilder(Colors.transparent, Colors.pink),
        textColorAppBar: const ColorBuilder(Colors.white),
        appBarBuilder: _appBar,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/brain1.gif",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              Container(
                child: Center(
                  child: ElevatedButton(
                    child: const Text(
                      'Start Reading',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => signalsScreen(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        fixedSize: const Size(300, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36,
                ),
                height: 700,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
      backgroundColor: colorAnimated.background,
      elevation: 0,
      title: Text(
        "Brain decoding",
        style: TextStyle(
          color: colorAnimated.color,
        ),
      ),
    );
  }
}
