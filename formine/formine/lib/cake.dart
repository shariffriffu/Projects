import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';

class BirthdayPage extends StatefulWidget {
  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> with TickerProviderStateMixin {
  late ConfettiController _confettiLeft;
  late ConfettiController _confettiRight;
  late AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _bgController;
  late AnimationController _pulseController;
  
  bool _wishMade = false;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    
    // Left and right confetti shooters
    _confettiLeft = ConfettiController(duration: const Duration(seconds: 4));
    _confettiRight = ConfettiController(duration: const Duration(seconds: 4));
    
    _confettiLeft.play();
    _confettiRight.play();
    
    _audioPlayer.play(AssetSource('fire.mp3'));

    // Animated shifting background gradient
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // Pulse animation controller for the interactive cake
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _confettiLeft.dispose();
    _confettiRight.dispose();
    _bgController.dispose();
    _pulseController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _triggerBirthdayBlast() {
    _confettiLeft.stop();
    _confettiRight.stop();
    _confettiLeft.play();
    _confettiRight.play();
    
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('fire.mp3'));
    
    setState(() {
      _tapCount++;
      if (_tapCount >= 1) {
        _wishMade = true;
      }
    });
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Animated Pastel Gradient Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              double val = _bgController.value;
              Color c1 = Color.lerp(const Color(0xFFF5E3F7), const Color(0xFFFFE5EC), val)!;
              Color c2 = Color.lerp(const Color(0xFFFFD2E8), const Color(0xFFFFF0F5), val)!;
              Color c3 = Color.lerp(const Color(0xFFE8F0FE), const Color(0xFFEAF5FF), val)!;
              
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [c1, c2, c3],
                  ),
                ),
              );
            },
          ),

          // Celebratory Floating Heart Background details
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/birthday.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Interactive Layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  
                  // Top Title
                  Text(
                    'HAPPY BIRTHDAY, BABY! ❤',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade700,
                      letterSpacing: 1.5,
                      shadows: [
                        const Shadow(
                          color: Colors.white70,
                          blurRadius: 10,
                          offset: Offset(0, 1),
                        ),
                        Shadow(
                          color: Colors.pinkAccent.withOpacity(0.35),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Interactive Prompt Message
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      _wishMade 
                          ? 'Wish made! I love you forever! 💖✨' 
                          : 'Tap the cake to blow the candles & make a wish! 🎂',
                      key: ValueKey<bool>(_wishMade),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: _wishMade ? Colors.purple.shade700 : Colors.pink.shade600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Interactive Pulsing Cake GIF
                  GestureDetector(
                    onTap: _triggerBirthdayBlast,
                    child: ScaleTransition(
                      scale: _pulseController,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.15),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Container(
                            width: 280,
                            height: 280,
                            color: Colors.white.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/ammu/cake.gif',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Left Confetti Launcher
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ConfettiWidget(
                      confettiController: _confettiLeft,
                      blastDirection: -pi / 3.5, // upward right
                      emissionFrequency: 0.06,
                      numberOfParticles: 25,
                      maxBlastForce: 25,
                      minBlastForce: 12,
                      colors: const [
                        Colors.pinkAccent,
                        Colors.purpleAccent,
                        Colors.amberAccent,
                        Colors.lightBlueAccent,
                      ],
                    ),
                  ),

                  // Right Confetti Launcher
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ConfettiWidget(
                      confettiController: _confettiRight,
                      blastDirection: -2.8 * pi / 3.5, // upward left
                      emissionFrequency: 0.06,
                      numberOfParticles: 25,
                      maxBlastForce: 25,
                      minBlastForce: 12,
                      colors: const [
                        Colors.pinkAccent,
                        Colors.purpleAccent,
                        Colors.amberAccent,
                        Colors.lightBlueAccent,
                      ],
                    ),
                  ),

                  // Outlined Exit Button
                  Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.pink.shade300, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: _exitApp,
                      child: Text(
                        'Close App',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink.shade700,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
