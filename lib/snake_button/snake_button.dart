import 'dart:math';
import 'package:flutter/material.dart';

class SnakeButton extends StatefulWidget {
  const SnakeButton({Key? key}) : super(key: key);

  @override
  State<SnakeButton> createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2500),
        upperBound: 2 * pi)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Snake Button'),
      ),
      body: Center(
        child: CustomPaint(
          foregroundPainter: SnakePainter(animation: _controller),
          child: Material(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(32),
                child: const Text('Snake Button'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  Animation animation;
  SnakePainter({
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(10),
    );

    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [Colors.white, Colors.red],
        stops: const [0.75, 1.0],
        startAngle: 0.0,
        endAngle: pi * 3 / 2,
        transform: GradientRotation(animation.value),
      ).createShader(Offset.zero & size);

    canvas.drawPath(
        Path.combine(
          PathOperation.xor,
          Path()..addRRect(rRect.deflate(4.0)),
          Path()
            ..addRRect(
              rRect.inflate(4.0),
            ),
        ),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
