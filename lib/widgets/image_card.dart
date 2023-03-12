import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageCard extends StatefulWidget {
  final Uint8List image;
  final String label;

  const ImageCard({super.key, required this.image, required this.label});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Image.memory(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.label,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              GestureDetector(
                onTap: () async {
                  await ImageGallerySaver.saveImage(widget.image,
                      name: widget.label);
                  const snackbar = SnackBar(
                      content: Text('Image Succesfully Saved to Gallery'));

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
