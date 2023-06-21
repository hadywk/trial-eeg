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
      1.16538735426537,
      0.3,
      1.207596972,
      1.366681162,
      0.9328492641,
      0.1620622691,
      -0.5690592292,
      -0.8578332704,
     0.8914925487,
      1.323471917,
      0.894634183,
      0.5549033327,
     -0.8724559273,
      -0.6835424392,
      -0.5886267323,
      -2.013184632,
      -1.028049912
    ]
  ];
  String predictedLabel = '';

  Future<String> predict() async {
    final url = Uri.parse('http://hadywk.pythonanywhere.com/predict');
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
      backgroundColor:Color.fromARGB(255, 5, 48, 84),
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
