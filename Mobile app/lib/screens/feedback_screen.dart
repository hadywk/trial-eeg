import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'face_detector_view.dart';

List<CameraDescription> cameras = [];

class Feedback_screen extends StatelessWidget {
  const Feedback_screen({Key? key}) : super(key: key);
  Future<void> opencam() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      debugPrint('CameraError: ${e.description}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: opencam(),
          builder: (context, snapshot) {
            return FaceDetectorView();
          }),
    );
  }
}
