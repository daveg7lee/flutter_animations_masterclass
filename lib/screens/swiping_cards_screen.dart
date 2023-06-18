import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);

  late final Tween<double> _scale = Tween(begin: 0.8, end: 1.0);

  late final Tween<double> _buttonScale = Tween(
    begin: 1.0,
    end: 0.8,
  );

  late final ColorTween _buttonColor = ColorTween(
    begin: Colors.amber,
    end: Colors.pink,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
    });
  }

  void _dismissCard({required bool forward, int duration = 300}) {
    final factor = forward ? 1 : -1;
    _position
        .animateTo((size.width + 100) * factor,
            duration: Duration(milliseconds: duration))
        .whenComplete(_whenComplete);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width / 2;
    if (_position.value >= bound || _position.value <= -bound) {
      _position.value.isNegative
          ? _dismissCard(forward: false)
          : _dismissCard(forward: true);
    } else {
      _position.animateTo(
        0,
        curve: Curves.elasticOut,
      );
    }
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swiping Cards"),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          final scale =
              _scale.transform(_position.value.abs() / (size.width + 100));
          final buttonScale = _buttonScale
              .transform(_position.value.abs() / (size.width + 100));
          final buttonColor = _buttonColor
              .transform(_position.value.abs() / (size.width + 100));

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 50,
                child: Transform.scale(
                    scale: min(scale, 1.0),
                    child: Card(
                      index: _index == 5 ? 1 : _index + 1,
                    )),
              ),
              Positioned(
                top: 50,
                child: GestureDetector(
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle * pi / 180,
                      child: Card(
                        index: _index,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _dismissCard(forward: false, duration: 200),
                      child: Transform.scale(
                        scale: _position.value.isNegative ? buttonScale : 1.0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: _position.value.isNegative
                                ? buttonColor
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _dismissCard(forward: true, duration: 200),
                      child: Transform.scale(
                        scale: _position.value.isNegative ? 1.0 : buttonScale,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: _position.value.isNegative
                                ? Colors.amber
                                : buttonColor,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;

  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.6,
        child: Image.asset(
          "assets/covers/$index.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
