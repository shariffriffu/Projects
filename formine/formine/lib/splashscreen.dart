import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer = AudioPlayer();
  int _currentMessageIndex = 0;
  final List<String> _messages = [
    "Have you put your headphones?",
    "This is for you, my better half❤",
    "Have some patience😁",
    "Remaining is for you. Click below👇",
    "Happy birthday, Begum❤"
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_currentMessageIndex < _messages.length - 1) {
          _currentMessageIndex++;
          if (_messages[_currentMessageIndex] == "Happy birthday, Begum❤") {
            playaudio("fire.mp3", 5); // Play audio multiple times simultaneously
            _confettiController.play();
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> playaudio(String audioPath, int timesToPlay) async {
    print("Inside playaudio: $audioPath");

    // Play audio multiple times simultaneously
    for (int i = 0; i < timesToPlay; i++) {
      _audioPlayer.play(AssetSource(audioPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/birthday.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _messages[_currentMessageIndex],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_currentMessageIndex == _messages.length - 1) // Check if it's the last message
                  Column(
                    children: [
                      SizedBox(height: 20.0), // Add space before the confetti
                      // Confetti Widget
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                        numberOfParticles: 500, // Increase number of particles for more effect
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple,
                        ],
                      ),
                      SizedBox(height: 20.0), // Add space before the heart image
                      // Heart-shaped image
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/ammu/11.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0), // Add space before the button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SurpriseHomePage(),
                            ),
                          );
                        },
                        child: Text('Go'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
