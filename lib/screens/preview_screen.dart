import 'dart:io';
import 'package:camera/camera.dart';
import 'package:detect_objects/Theme/themes.dart';
import 'package:detect_objects/screens/objects_screen.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final XFile image;

  const PreviewScreen({super.key, required this.image});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late var img = Image.file(File(widget.image.path));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          img,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(gradient: CustomThemes.gradient),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ObjectsScreen(image: widget.image),
                    ));
                  },
                  child: const Text('Intelligent Zoom'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
