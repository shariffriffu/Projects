import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:io';

import 'package:flutter/services.dart';


class BirthdayPage extends StatefulWidget {
  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
          _audioPlayer.play(AssetSource('fire.mp3'));

  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      body: Stack(
        children: [
          // Cake animation (GIF)
          Center(
            child: Image.asset(
              'assets/ammu/cake.gif', // Replace with your GIF file path
              width: 300, // Adjust width as needed
              height: 300, // Adjust height as needed
              fit: BoxFit.cover, // Adjust the fit type as needed
            ),
          ),
          // Text "Happy Birthday Baby"
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Happy Birthday Baby❤',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Confetti animation
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -1.0, // Change the direction if needed
                emissionFrequency: 0.05, // Adjust emission frequency
                numberOfParticles: 20, // Number of confetti particles
                maxBlastForce: 20, // Maximum blast force
                minBlastForce: 8, // Minimum blast force
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ], // Colors of confetti
              ),
            ),
          ),
          // Exit button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _exitApp,
              child: Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
