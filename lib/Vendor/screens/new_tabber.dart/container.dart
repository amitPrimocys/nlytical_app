import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nlytical_app/utils/colors.dart';

class CustomContaine extends StatefulWidget {
  const CustomContaine({super.key});

  @override
  State<CustomContaine> createState() => _CustomContaineState();
}

class _CustomContaineState extends State<CustomContaine> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          child: ReverseBorderRadius(
              radius: 50, color: AppColors.blue, child: SizedBox(height: 10)),
        ),
      ),
    );
  }
}

class InvertedRoundedRectanglePainter extends CustomPainter {
  InvertedRoundedRectanglePainter({
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final cornerSize = Size.square(radius * 2);
    canvas.drawPath(
      Path()
        ..addArc(
          // top-left arc
          Offset(0, -radius * 2) & cornerSize,
          // 180 degree startAngle (left of circle)
          pi,
          // -90 degree sweepAngle (counter-clockwise to the bottom)
          -pi / 2,
        )
        ..arcTo(
          // top-right arc
          Offset(size.width - cornerSize.width, -radius * 2) & cornerSize,
          // 90 degree startAngle (bottom of circle)
          pi / 2,
          // -90 degree sweepAngle (counter-clockwise to the right)
          -pi / 2,
          false,
        )
        // line under the arcs
        ..lineTo(size.width, 0)
        ..lineTo(0, 0),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(InvertedRoundedRectanglePainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.color != color;
}

class ReverseBorderRadius extends StatelessWidget {
  const ReverseBorderRadius({
    super.key,
    required this.radius,
    required this.color,
    required this.child,
  });

  final double radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: InvertedRoundedRectanglePainter(
          radius: radius,
          color: color,
        ),
        child: child);
  }
}
