import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Custom painter that draws an animated, 3D Z-sorted DNA double-helix.
class DnaHelixPainter extends CustomPainter {
  final double animationProgress;
  final Color color;

  DnaHelixPainter({
    required this.animationProgress,
    this.color = AppColors.primary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final strandPaintFront = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
      
    final strandPaintBack = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final rungPaintFront = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
      
    final rungPaintBack = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final dotPaintFront = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
      
    final dotPaintBack = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final cx = w / 2;
    final cxNorm = w * 0.45; // amplitude
    final topPad = h * 0.05;
    final botPad = h * 0.05;
    final drawH = h - topPad - botPad;

    const steps = 80;
    const twists = 1.5;
    final phase = animationProgress * 2 * pi;

    final pathFront = Path();
    final pathBack = Path();

    // Arrays to store strand points for rung calculations
    final List<Offset> s1Points = [];
    final List<double> s1Z = [];
    final List<Offset> s2Points = [];
    final List<double> s2Z = [];

    Offset? lastP1;
    Offset? lastP2;
    double? lastZ1;
    double? lastZ2;

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final y = topPad + drawH * t;
      final angle = 2 * pi * twists * t + phase;

      // 3D coordinates projection
      final z1 = cos(angle);
      final x1 = cx + cxNorm * sin(angle);
      
      final z2 = -cos(angle);
      final x2 = cx - cxNorm * sin(angle);

      final p1 = Offset(x1, y);
      final p2 = Offset(x2, y);

      s1Points.add(p1);
      s1Z.add(z1);
      s2Points.add(p2);
      s2Z.add(z2);

      if (i > 0) {
        final lP1 = lastP1!;
        final lP2 = lastP2!;
        final lZ1 = lastZ1!;
        final lZ2 = lastZ2!;

        // Strand 1
        if (z1 > 0 && lZ1 > 0) {
          pathFront.moveTo(lP1.dx, lP1.dy);
          pathFront.lineTo(p1.dx, p1.dy);
        } else {
          pathBack.moveTo(lP1.dx, lP1.dy);
          pathBack.lineTo(p1.dx, p1.dy);
        }

        // Strand 2
        if (z2 > 0 && lZ2 > 0) {
          pathFront.moveTo(lP2.dx, lP2.dy);
          pathFront.lineTo(p2.dx, p2.dy);
        } else {
          pathBack.moveTo(lP2.dx, lP2.dy);
          pathBack.lineTo(p2.dx, p2.dy);
        }
      }

      lastP1 = p1;
      lastP2 = p2;
      lastZ1 = z1;
      lastZ2 = z2;
    }

    // Draw background elements first
    canvas.drawPath(pathBack, strandPaintBack);

    const rungCount = 4;
    for (int i = 0; i < rungCount; i++) {
      final t = (i + 0.5) / rungCount;
      final idx = (t * steps).round().clamp(0, steps);
      
      final p1 = s1Points[idx];
      final z1 = s1Z[idx];
      final p2 = s2Points[idx];
      final z2 = s2Z[idx];

      // If both strands are somewhat in back, rung is in back.
      // Easiest Z check: sum of z
      final isFront = (z1 + z2) > -0.5;

      canvas.drawLine(p1, p2, isFront ? rungPaintFront : rungPaintBack);
      
      // Draw connection dots
      canvas.drawCircle(p1, 1.8, z1 > 0 ? dotPaintFront : dotPaintBack);
      canvas.drawCircle(p2, 1.8, z2 > 0 ? dotPaintFront : dotPaintBack);
    }

    // Draw foreground elements on top
    canvas.drawPath(pathFront, strandPaintFront);
  }

  @override
  bool shouldRepaint(covariant DnaHelixPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.color != color;
  }
}
