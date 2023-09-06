import 'package:astro_prototype/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TriangleWidget extends StatelessWidget {
  final double size;
  final Color color;

  TriangleWidget({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: CustomPaint(
        painter: TrianglePainter(),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = BOX_COLOR
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0) // Top-right corner
      ..lineTo(0, size.height) // Bottom-left corner
      ..lineTo(size.width, size.height); // Bottom-right corner

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
