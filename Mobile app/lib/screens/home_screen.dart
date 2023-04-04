import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/material.dart';

import 'processing_signals_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
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
              Container(child: Center(
                child: ElevatedButton(child: const Text('Start Reading',style: TextStyle(fontSize: 20),), onPressed:()=>signalsScreen(context), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              fixedSize: const Size(300, 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),),
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