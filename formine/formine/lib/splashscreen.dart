import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer = AudioPlayer();
  int _currentMessageIndex = 0;
  final List<String> _messages = [
    "Have you put your headphones? 🎧",
    "This is for you, my better half ❤",
    "Have some patience... 😁",
    "I have made something special for you. Click below 👇",
    "Happy Birthday, Begum ❤"
  ];
  late Timer _timer;
  late AnimationController _pulseController;
  bool _isLetterOpen = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    // Pulse animation controller for headphones icon
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      if (mounted) {
        setState(() {
          if (_currentMessageIndex < _messages.length - 1) {
            _currentMessageIndex++;
            if (_messages[_currentMessageIndex].contains("Happy Birthday")) {
              _confettiController.play();
            }
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _confettiController.dispose();
    _pulseController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playaudio(String audioPath) async {
    print("Inside playaudio: $audioPath");
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource(audioPath));
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastMessage = _currentMessageIndex == _messages.length - 1;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/birthday.jpg",
            fit: BoxFit.cover,
          ),
          
          // Shimmering Rose/Dark Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.purple.withOpacity(0.25),
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
          ),

          // Confetti overlay
          if (isLastMessage)
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                numberOfParticles: 20,
                colors: const [
                  Colors.pinkAccent,
                  Colors.purpleAccent,
                  Colors.amberAccent,
                  Colors.white,
                ],
              ),
            ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // Pulsing Icon for headphones
                  if (_currentMessageIndex == 0)
                    ScaleTransition(
                      scale: _pulseController,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.headset_rounded,
                          color: Colors.pinkAccent,
                          size: 48,
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Glassmorphic Card for the messages
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        _messages[_currentMessageIndex],
                        key: ValueKey<int>(_currentMessageIndex),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.pinkAccent.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  if (isLastMessage) ...[
                    // Custom Wax Seal Envelope Widget
                    WaxSealEnvelope(
                      onOpened: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SurpriseHomePage(),
                          ),
                        );
                      },
                      onSealBroken: () {
                        playaudio("fire.mp3");
                      },
                      onLetterOpened: () {
                        setState(() {
                          _isLetterOpen = true;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Swipe or Tap the Seal to Open 🕯️",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.pinkAccent.withOpacity(0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_isLetterOpen)
                      Text(
                        "(Tap anywhere to open the letter)",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),

          // Transparent tap target covering the whole screen when letter is fully slid out
          if (_isLetterOpen)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SurpriseHomePage(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// Interactive 3D Wax Seal Envelope Widget
// -------------------------------------------------------------
class WaxSealEnvelope extends StatefulWidget {
  final VoidCallback onOpened;
  final VoidCallback onSealBroken;
  final VoidCallback? onLetterOpened;

  const WaxSealEnvelope({
    Key? key,
    required this.onOpened,
    required this.onSealBroken,
    this.onLetterOpened,
  }) : super(key: key);

  @override
  _WaxSealEnvelopeState createState() => _WaxSealEnvelopeState();
}

class _WaxSealEnvelopeState extends State<WaxSealEnvelope> with TickerProviderStateMixin {
  bool _isBroken = false;
  double _dragProgress = 0.0;
  late AnimationController _envelopeController;
  late AnimationController _sealPulseController;

  @override
  void initState() {
    super.initState();
    _envelopeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onLetterOpened?.call();
        }
      });
    _sealPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.94,
      upperBound: 1.06,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _envelopeController.dispose();
    _sealPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. The letter (slides out upwards from the back of the envelope)
          AnimatedBuilder(
            animation: _envelopeController,
            builder: (context, child) {
              double slideY = -85 * _envelopeController.value;
              double scale = 0.92 + 0.08 * _envelopeController.value;
              return Transform.translate(
                offset: Offset(0, slideY),
                child: Transform.scale(
                  scale: scale,
                  child: GestureDetector(
                    onTap: _envelopeController.isCompleted ? widget.onOpened : null,
                    child: Container(
                      width: 250,
                      height: 150,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF6), // Antique paper color
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFFDFA3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite_rounded, color: Colors.pinkAccent, size: 36),
                          const SizedBox(height: 8),
                          Text(
                            "Tap to Open Letter 💌",
                            style: TextStyle(
                              color: Colors.pink.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "My Heart inside... ❤",
                            style: TextStyle(
                              color: Colors.pink.shade300,
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // 2. The Envelope main body
          IgnorePointer(
            ignoring: _isBroken,
            child: Container(
              width: 270,
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFE56A8F), // Solid envelope color
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: const Color(0xFFFF597B).withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),
          
          // 3. The Envelope open flap (flips upwards)
          Positioned(
            top: 59,
            child: IgnorePointer(
              ignoring: _isBroken,
              child: AnimatedBuilder(
                animation: _envelopeController,
                builder: (context, child) {
                  // Rotates from 0.0 (pointing down) to 1.0 (pointing straight up / flipped back)
                  double rotX = _envelopeController.value * 3.14159;
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002) // Perspective depth
                      ..rotateX(rotX),
                    alignment: Alignment.topCenter,
                    child: ClipPath(
                      clipper: FlapClipper(),
                      child: Container(
                        width: 270,
                        height: 100,
                        color: const Color(0xFFFF597B),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 4. The Wax Seal (pulses, breaks open upon swipe/tap)
          if (!_isBroken) ...[
            // Glowing animated drag arrows
            Positioned(
              top: 132,
              child: AnimatedBuilder(
                animation: _sealPulseController,
                builder: (context, child) {
                  double offset = 35 + 15 * ((_sealPulseController.value - 0.94) / 0.12);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(-offset, 0),
                        child: const Icon(Icons.keyboard_double_arrow_left_rounded, color: Colors.pinkAccent, size: 24),
                      ),
                      const SizedBox(width: 40),
                      Transform.translate(
                        offset: Offset(offset, 0),
                        child: const Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.pinkAccent, size: 24),
                      ),
                    ],
                  );
                },
              ),
            ),
            AnimatedBuilder(
              animation: _sealPulseController,
              builder: (context, child) {
                return Positioned(
                  top: 120,
                  child: Transform.scale(
                    scale: _sealPulseController.value,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isBroken = true;
                          _sealPulseController.stop();
                          widget.onSealBroken();
                          _envelopeController.forward();
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _dragProgress += details.primaryDelta! / 60.0;
                          if (_dragProgress.abs() >= 1.0) {
                            _isBroken = true;
                            _sealPulseController.stop();
                            widget.onSealBroken();
                            _envelopeController.forward();
                          }
                        });
                      },
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _dragProgress += details.primaryDelta! / 60.0;
                          if (_dragProgress.abs() >= 1.0) {
                            _isBroken = true;
                            _sealPulseController.stop();
                            widget.onSealBroken();
                            _envelopeController.forward();
                          }
                        });
                      },
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC62828), // Crimson red seal
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFB71C1C), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.shade900.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

// Clipper for envelope triangular flap
class FlapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
