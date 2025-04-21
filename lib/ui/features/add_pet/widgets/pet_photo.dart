import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class PetPhoto extends StatelessWidget {
  const PetPhoto({
    super.key, 
    required this.image
  });

  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(color: context.theme.main.inputFieldLabelColor),
      child: SizedBox(
        width: 10,
        height: 100,
        child: image == null
          ? Center(
              child: Icon(
                Icons.add_circle_outline_outlined,
                color: context.theme.main.inputFieldLabelColor,
                size: 38,
              ),
            )
          : ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.file(
              File(image!.path),
              fit: BoxFit.cover,
            ),
          )
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 4,
    this.dashWidth = 10,
    this.dashSpace = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(28),
      ));

    double distance = 0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final segmentLength = dashWidth + dashSpace;
        final end = (distance + dashWidth).clamp(0.0, pathMetric.length);
        canvas.drawPath(pathMetric.extractPath(distance, end), paint);
        distance += segmentLength;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}