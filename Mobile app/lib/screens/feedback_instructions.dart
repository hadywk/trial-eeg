import 'package:flutter/material.dart';
import 'package:graduation/screens/feedback_screen2.dart';
import 'feedback_screen.dart';

class FeedbackInstructions extends StatelessWidget {
  const FeedbackInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    _info() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Instructions', textAlign: TextAlign.center),
          content: Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Text(
                    "⚫ The Following option enables the patient to record feedback using eye detection.  "),
                Text("⁃ Left Eye blink to Accept."),
                Text("⁃ Right Eye blink to Refuse.")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    _info2() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Instructions', textAlign: TextAlign.center),
          content: Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Text(
                    "⚫ The Following option enables the patient to record feedback using Emotion detection.  "),
                Text(
                  "⁃ Happy Face refers to Right result.",
                  textAlign: TextAlign.start,
                ),
                Text(
                  "⁃ Sad Face refers to Wrong result.",
                  textAlign: TextAlign.start,
                ),
                Text(
                  "⁃ Neutral Face refers to Satisfactory result.",
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                "According to the type of Disability, choose the most suitable option for the feedback!",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
          ),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.info), onPressed: () => _info()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Feedback_screen()),
                  );
                },
                child: Text(
                  "Eye Detection",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(233, 30, 99, 1),
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.info), onPressed: () => _info2()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Feedback_screen2()),
                  );
                },
                child: Text(
                  "Emotion Detection",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(233, 30, 99, 1),
                    fixedSize: const Size(300, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
