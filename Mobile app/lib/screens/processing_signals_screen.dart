import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graduation/screens/results.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProcessingSignals extends StatefulWidget {
  const ProcessingSignals({super.key});

  @override
  State<ProcessingSignals> createState() => _ProcessingSignalsState();
}

class _ProcessingSignalsState extends State<ProcessingSignals> {
  void resultsScreen(BuildContext ctx) {
    predict().then((value){
       Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Results(predicted_result: value,);
        },
      ),
    );
    });
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return Results();
    //     },
    //   ),
    // );
  }

  final List<List<double>> eegData = [
    [
      0.2,
      0.3,
      0.5,
      0.1,
      0.6,
      0.8,
      0.4,
      0.7,
      0.9,
      0.2,
      0.3,
      0.5,
      0.1,
      0.6,
      0.8,
      0.4,
      0.5
    ]
  ];
  String predictedLabel = '';

  Future<String> predict() async {
    final url = Uri.parse('http://192.168.1.12:8000/predict');
    final eegDataJson = json.encode({
      'eeg_data': eegData,
    });
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: eegDataJson,
    );
    final data = json.decode(response.body);
    return data['label'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 200,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 10),
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
                    FlickerAnimatedText('Processing Signals',
                        textAlign: TextAlign.center),
                  ],
                  onTap: () {
                    resultsScreen(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
