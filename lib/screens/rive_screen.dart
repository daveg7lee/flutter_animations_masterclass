import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController =
        StateMachineController.fromArtboard(artboard, "State Machine 1")!;
    artboard.addController(_stateMachineController);
  }

  void _togglePanel() {
    final input = _stateMachineController.findInput<bool>("panelActive")!;
    input.change(!input.value);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive"),
      ),
      body: Center(
        child: Container(
          color: const Color.fromRGBO(85, 84, 203, 1),
          width: double.infinity,
          child: RiveAnimation.asset(
            "assets/animations/stars-animation.riv",
            artboard: "New Artboard",
            stateMachines: const ['State Machine 1'],
            onInit: _onInit,
          ),
        ),
      ),
    );
  }
}
