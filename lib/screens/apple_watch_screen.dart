import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..forward();

  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);

  List<double> _getRandomValueList({int count = 3}) {
    return List.generate(count, (_) => Random().nextDouble() * 2.0 * pi);
  }

  late final List<double> _initProgressPoints = _getRandomValueList();

  late final List<Animation<double>> _progressList = List.generate(
    3,
    (index) => Tween(
      begin: 0 * pi,
      end: _initProgressPoints[index],
    ).animate(_curve),
  );

  void _animateValues() {
    final newBeginPoints = _progressList //
        .map((e) => e.value)
        .toList();
    final newEndPoints = _getRandomValueList();

    _progressList.asMap().forEach((idx, _) {
      _progressList[idx] = Tween(
        begin: newBeginPoints[idx],
        end: newEndPoints[idx],
      ).animate(_curve);
    });

    setState(() {
      _animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Apple Watch"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _progressList[0],
          builder: (context, child) => CustomPaint(
            painter: AppleWatchPainter(
              progressList: _progressList.map((e) => e.value).toList(),
            ),
            size: const Size(400, 400),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final List<double> progressList;

  AppleWatchPainter({required this.progressList});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final redCircleRadius = (size.width / 2) * 0.9;
    final greenCircleRadius = (size.width / 2) * 0.76;
    final blueCircleRadius = (size.width / 2) * 0.62;
    const startingAngle = -0.5 * pi;

    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    final greenCirclePain = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, greenCircleRadius, greenCirclePain);

    final blueCirclePain = Paint()
      ..color = Colors.cyan.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, blueCircleRadius, blueCirclePain);

    final redArcRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );

    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      progressList[0],
      false,
      redArcPaint,
    );

    final greenArcRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );

    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      greenArcRect,
      startingAngle,
      progressList[1],
      false,
      greenArcPaint,
    );

    final blueArcRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );

    final blueArcPaint = Paint()
      ..color = Colors.cyan.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      blueArcRect,
      startingAngle,
      progressList[2],
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progressList[0] != progressList[0] ||
        oldDelegate.progressList[1] != progressList[1] ||
        oldDelegate.progressList[2] != progressList[2];
  }
}
