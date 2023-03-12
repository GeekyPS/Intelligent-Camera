
import 'package:camera/camera.dart';
import 'package:detect_objects/controllers/recognition_store.dart';
import 'package:image/image.dart';
import 'dart:math' as math;

Future<List<Map<String, dynamic>>> zoomImage(XFile image, String path) async {
  final imgBytes = await image.readAsBytes();

  Image? abc = decodeImage(imgBytes);
  if (abc != null) {
    final zoomCrops = getZoomSizes();

    List<Map<String, dynamic>> list = [];

    for (var i = 0; i < zoomCrops.length; i++) {
      final zoomImage = copyCrop(
        abc,
        x: (zoomCrops[i]['rect']['x'] as double).round(),
        y: (zoomCrops[i]['rect']['y'] as double).round(),
        width: (zoomCrops[i]['rect']['w'] as double).round(),
        height: ((zoomCrops[i]['rect']['h']) as double).round(),
      );

      list.add({
        'label': zoomCrops[i]['detectedClass'],
        'image': encodeNamedImage(path, zoomImage)
      });
    }
    return list;
  } else {
    return [];
  }
}

List<Map<dynamic, dynamic>> getZoomSizes() {
  final results = RecognitionStore.recognition;

  final int previewH = RecognitionStore.previewH;
  final int previewW = RecognitionStore.previewW;

  return results.map((re) {
    var x0 = re["rect"]["x"];
    var w0 = re["rect"]["w"];
    var y0 = re["rect"]["y"];
    var h0 = re["rect"]["h"];
    double x1 = math.max(0, x0 * previewW);
    double y1 = math.max(0, y0 * previewH);
    double w1 = w0 * previewW;
    double h1 = h0 * previewH;

    return {
      'rect': {'x': x1, 'y': y1, 'w': w1, 'h': h1},
      'detectedClass': re['detectedClass']
    };
  }).toList();
}
