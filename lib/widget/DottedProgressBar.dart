import 'dart:math';

import 'package:exerciseapp/Core/Constant/AppColors.dart';
import 'package:flutter/material.dart';

class DottedProgressBar extends CustomPainter {
  final int totalDuration;
  final int elapsedDuration;
  final bool isRunning;

  DottedProgressBar({
    required this.totalDuration,
    required this.elapsedDuration,
    required this.isRunning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.primary
      ..style = isRunning ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY) - 10.0;
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * elapsedDuration / totalDuration;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    final Paint dottedPaint = Paint()
      ..color = isRunning ? AppColors.subTextColor : AppColors.primary
      ..style = isRunning ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (double angle = 0; angle < 2 * pi; angle += pi / 12) {
      final x1 = centerX + radius * cos(angle);
      final y1 = centerY + radius * sin(angle);
      final x2 = centerX + (radius - 10) * cos(angle);
      final y2 = centerY + (radius - 10) * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dottedPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}