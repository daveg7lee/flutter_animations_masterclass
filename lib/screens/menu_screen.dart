import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/implicits_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(context, const ImplicitAnimationsScreen());
                  },
                  child: const Text("Implicit Animations"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Implicit Animations"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
