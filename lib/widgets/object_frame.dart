import 'package:detect_objects/Theme/themes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ObjectFrame extends StatelessWidget {
  final List<dynamic>? results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  const ObjectFrame({super.key, this.results, required this.previewH, required this.previewW, required this.screenH, required this.screenW});
  @override
  Widget build(BuildContext context) {
    if (results == null) {
      return Container();
    }


    List<Widget> renderBox() {
      return results!.map((re) {
        var x0 = re["rect"]["x"];
        var w0 = re["rect"]["w"];
        var y0 = re["rect"]["y"];
        var h0 = re["rect"]["h"];

        double scaleW, scaleH, x, y, w, h;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (x0 - difW / 2) * scaleW;
          w = w0 * scaleW;
          if (x0 < difW / 2) w -= (difW / 2 - x0) * scaleW;
          y = y0 * scaleH;
          h = h0 * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = x0 * scaleW;
          w = w0 * scaleW;
          y = (y0 - difH / 2) * scaleH;
          h = h0 * scaleH;
          if (y0 < difH / 2) h -= (difH / 2 - y0) * scaleH;
        }
        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => CustomThemes.gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),

            child: Container(
              padding:const EdgeInsets.only(top: 5.0, left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                ),
              ),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                 shaderCallback: (bounds) => CustomThemes.gradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Text(
                  "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
       
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList();
    }

    return Stack(
      children: renderBox(),
    );
  }
}
