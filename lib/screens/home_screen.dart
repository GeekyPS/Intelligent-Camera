import 'package:detect_objects/Theme/themes.dart';
import 'package:detect_objects/controllers/recognition_store.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../widgets/camera.dart';
import '../widgets/object_frame.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({super.key, required this.cameras});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  static const _model = "SSD MobileNet";
  bool _isCameraRunning = false;

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
    RecognitionStore.recognition = _recognitions ?? [];
    RecognitionStore.previewH = math.max(_imageHeight, _imageWidth);
    RecognitionStore.previewW = math.min(_imageHeight, _imageWidth);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Intelligent Camera',
        ),
        leading: Visibility(
          visible: _isCameraRunning,
          child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _isCameraRunning = false;
                });
              }),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomThemes.gradient,
        ),
        child: !_isCameraRunning
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 300))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Open The Smart Camera',
                          ),
                        ],
                      ),
                      onPressed: () => setState(() {
                        _isCameraRunning = true;
                      }),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Camera(
                    cameras: widget.cameras,
                    model: _model,
                    setRecognitions: setRecognitions,
                    closeCameraCallback: () {
                      setState(() {
                        _isCameraRunning = false;
                      });
                    },
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: ObjectFrame(
                      results: _recognitions,
                      previewH: math.max(_imageHeight, _imageWidth),
                      previewW: math.min(_imageHeight, _imageWidth),
                      screenH: screen.height,
                      screenW: screen.width,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
