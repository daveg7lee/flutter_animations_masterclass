import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/apple_watch_screen.dart';
import 'package:flutter_animations_masterclass/screens/container_transform_screen.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicits_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_animations_masterclass/screens/rive_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';

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
                  onPressed: () {
                    _goToPage(context, const ExplicitAnimationsScreen());
                  },
                  child: const Text("Explicit Animations"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(context, const AppleWatchScreen());
                  },
                  child: const Text("Apple Watch"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(context, const SwipingCardsScreen());
                  },
                  child: const Text("Swiping Cards"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(
                      context,
                      const MusicPlayerScreen(),
                    );
                  },
                  child: const Text("Music Player"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(
                      context,
                      const RiveScreen(),
                    );
                  },
                  child: const Text("Rive"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    _goToPage(
                      context,
                      const ContainerTransformScreen(),
                    );
                  },
                  child: const Text("Container Tramsform"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
