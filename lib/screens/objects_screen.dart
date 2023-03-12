import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:detect_objects/Theme/themes.dart';
import 'package:detect_objects/controllers/zoom_controller.dart';
import 'package:detect_objects/widgets/image_card.dart';
import 'package:flutter/material.dart';

class ObjectsScreen extends StatelessWidget {
  final XFile image;

  const ObjectsScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List images = snapshot.data!;
            return Container(
              decoration: const BoxDecoration(gradient: CustomThemes.gradient),
              child: ListView.builder(
                itemBuilder: (context, index) => ImageCard(
                    image: images[index]['image'] as Uint8List,
                    label: images[index]['label']),
                itemCount: images.length,
              ),
            );
          } else {
            return Container();
          }
        },
        future: zoomImage(image, image.path),
      ),
    );
  }
}
