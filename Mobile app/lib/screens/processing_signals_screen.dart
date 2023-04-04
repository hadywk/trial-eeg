import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation/screens/results.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ProcessingSignals extends StatefulWidget {
  const ProcessingSignals({super.key});

  @override
  State<ProcessingSignals> createState() => _ProcessingSignalsState();
}

class _ProcessingSignalsState extends State<ProcessingSignals> {

    void resultsScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Results();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.pink,
    body: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height/3,),
        Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: Colors.white,
            size: 200,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/10),
        Center(
          child: SizedBox(
  width: 300.0,
  child: DefaultTextStyle(
    style: const TextStyle(
      fontSize: 35,
      color: Colors.white,
      shadows: [
          Shadow(
            blurRadius: 7.0,
            color: Colors.white,
            offset: Offset(0, 0),
          ),
      ],
    ),
    child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
          FlickerAnimatedText('Processing Signals',textAlign: TextAlign.center),
      ],
      onTap: () {
          resultsScreen(context);
      },
    ),
  ),
),
        ),
      ],
    ),);
  }
}