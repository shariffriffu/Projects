// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:formine/memories.dart';
import 'splashscreen.dart';

void main() {
  runApp(MySurpriseApp());
}

class MySurpriseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surprise App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: SplashScreen(),
    );
  }
}

class SurpriseHomePage extends StatefulWidget {
  @override
  _SurpriseHomePageState createState() => _SurpriseHomePageState();
}

class _SurpriseHomePageState extends State<SurpriseHomePage>
    with TickerProviderStateMixin {
  late ConfettiController _controllerCenter;
  late AnimationController _pulseController;
  late Timer _backgroundTimer;
  int _currentImageIndex = 0;
  int _currentMessageIndex = 0;
  late PageController _pageController;
  
  final List<String> _backgroundImages = [
    'assets/ammu/1.jpg',
    'assets/ammu/2.jpg',
    'assets/ammu/3.jpg',
    'assets/ammu/4.jpg',
    'assets/ammu/5.jpg',
    'assets/ammu/6.jpg',
    'assets/ammu/7.jpg',
    'assets/ammu/8.jpg',
    'assets/ammu/9.jpg',
    'assets/ammu/10.jpg',
    'assets/ammu/11.jpg',
    'assets/ammu/12.jpg',
  ];

  final List<String> _messages = [
    'My love 🥰!\n\nFrom the moment we met, you’ve brought an unparalleled joy and warmth into my life 😍.\n\nYour smile and support help me fight through the darkest days, and I am endlessly grateful for your presence 😘.',
    'You are not just my lover 😘,\n\nbut my best friend 😍, confidante, incredible partner, and my future wife 🥰.\n\nYour kindness, compassion, and endless patience inspire me daily. Your contagious optimism makes you truly remarkable!',
    'Happy birthday, my love! ❤\n\nI wish you all the happiness and fulfillment your heart desires.\n\nYou are the love of my life, and I promise to cherish, support, and love you more with each passing day.',
    'On this day, I may not be physically in front of you but...\n\nI am always present in your heart, and I am here virtually to say that:\n\n"Saranghae 💜"',
    'Thank you for handling me and keeping me guided like always ❤.\n\nHelp me build the beautiful future we have always dreamed of for Us. 😘',
    'Happy Birthday, my beautiful queen! 👑🎂'
  ];

  late AudioPlayer _audioPlayer = AudioPlayer();
  late AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    _controllerCenter.addListener(() {
      if (_controllerCenter.state == ConfettiControllerState.stopped) {
        _controllerCenter.play();
      }
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);

    _backgroundTimer = Timer.periodic(Duration(seconds: 7), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });

    _initAudioPlayer();

    _pageController = PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == _backgroundImages.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _pulseController.dispose();
    _backgroundTimer.cancel();
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _initAudioPlayer() {
    _audioCache = AudioCache();
    _audioCache.load('alert.mp3');
    playaudio("alert.mp3", 1);
  }

  void _playMusic() {
    playaudio("alert.mp3", 1);
  }

  void _pauseMusic() {
    stopplay();
  }

  Future<void> playaudio(String audio, int sec) async {
    print("Inside playaudio: $audio");
    return Future.delayed(Duration(seconds: sec), () {
      _audioPlayer.play(AssetSource(audio));
    });
  }

  Future<void> stopplay() async {
    print("Inside stoppplay");
    _audioPlayer.stop();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'Completion Check 🌸',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade700),
            ),
            content: Text('Have you completed reading all the slides, my love?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes, let\'s go!', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
                onPressed: () {
                  stopplay();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MemoriesPage()),
                  );
                },
              ),
              TextButton(
                child: Text('Not yet', style: TextStyle(color: Colors.grey.shade600)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAlertMessage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlertMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Sweet Reminder 💖'),
          content: Text('Please take your time and read all the messages I wrote for you.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay', style: TextStyle(color: Colors.pink)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _incrementMessageIndex() {
    setState(() {
      _currentMessageIndex++;
      if (_currentMessageIndex >= _messages.length) {
        _showCompletionDialog();
        _currentMessageIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ken Burns zooming background slideshow
          AnimatedSwitcher(
            duration: Duration(milliseconds: 1400),
            child: TweenAnimationBuilder<double>(
              key: ValueKey<int>(_currentImageIndex),
              tween: Tween<double>(begin: 1.15, end: 1.0),
              duration: Duration(seconds: 7),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_backgroundImages[_currentImageIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Rose/Dark glassmorphic overlay for layout separation
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
          ),

          // Rising Heart Particles
          Positioned.fill(
            child: FloatingHeartsWidget(),
          ),

          // Confetti overlay
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              emissionFrequency: 0.02,
              numberOfParticles: 40,
              colors: const [
                Colors.pinkAccent,
                Colors.purpleAccent,
                Colors.amberAccent,
                Colors.white,
              ],
            ),
          ),

          // Main content layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                children: [
                  // Top bar with pause/play & done button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Music control glass button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.music_off_rounded, color: Colors.white),
                          onPressed: () {
                            stopplay();
                          },
                        ),
                      ),
                      
                      // Pulse heart check button at top right
                      ScaleTransition(
                        scale: _pulseController,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pinkAccent, Colors.purpleAccent],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pinkAccent.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.favorite, color: Colors.white, size: 28),
                            onPressed: _showCompletionDialog,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Handwritten Notebook Scroll Letter Container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF0), // Warm notebook color
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFE2C999), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: PaperLinesPainter(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50.0, right: 24.0, top: 24.0, bottom: 20.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: TypewriterText(
                                key: ValueKey<int>(_currentMessageIndex),
                                text: _messages[_currentMessageIndex],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.55,
                                  color: const Color(0xFF0F2C59), // Elegant Navy Pen Ink
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Bottom Navigation controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Replay / Reset slides
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.music_note_rounded, color: Colors.white),
                          onPressed: _playMusic,
                        ),
                      ),
                      
                      // Progress dot indicator
                      Row(
                        children: List.generate(
                          _messages.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: _currentMessageIndex == index ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentMessageIndex == index ? Colors.pinkAccent : Colors.white60,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // Next button
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Color(0xFFE56A8F)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.3),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 28),
                          onPressed: _incrementMessageIndex,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// Typewriter Text Widget
// -------------------------------------------------------------
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;

  const TypewriterText({
    Key? key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 25),
  }) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _startTyping();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer?.cancel();
    _displayedText = "";
    int index = 0;
    _timer = Timer.periodic(widget.speed, (timer) {
      if (index < widget.text.length) {
        if (mounted) {
          setState(() {
            _displayedText += widget.text[index];
          });
        }
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style,
      textAlign: TextAlign.left,
    );
  }
}

// -------------------------------------------------------------
// School Notebook Paper Lines Painter
// -------------------------------------------------------------
class PaperLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.lightBlue.shade100.withOpacity(0.4)
      ..strokeWidth = 1.2;

    // Draw horizontal lines across the paper scroll
    double lineGap = 28.0;
    for (double y = 15.0 + lineGap; y < size.height; y += lineGap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    
    // Draw red margin line on the left side
    final marginPaint = Paint()
      ..color = Colors.red.shade200.withOpacity(0.6)
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(38, 0), Offset(38, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -------------------------------------------------------------
// Floating Hearts Particle Widget
// -------------------------------------------------------------
class FloatingHeartsWidget extends StatefulWidget {
  const FloatingHeartsWidget({Key? key}) : super(key: key);

  @override
  _FloatingHeartsWidgetState createState() => _FloatingHeartsWidgetState();
}

class _FloatingHeartsWidgetState extends State<FloatingHeartsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_HeartParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Periodically add new particles
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_particles.length < 20) {
        setState(() {
          _particles.add(_HeartParticle(
            x: _random.nextDouble(),
            speed: 0.08 + _random.nextDouble() * 0.12,
            scale: 0.4 + _random.nextDouble() * 0.8,
            rotation: _random.nextDouble() * 0.4 - 0.2,
            opacity: 0.15 + _random.nextDouble() * 0.5,
          ));
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update positions
        for (var particle in _particles) {
          particle.y += particle.speed * 0.0045;
          if (particle.y > 1.1) {
            particle.y = 0.0;
            particle.x = _random.nextDouble();
          }
        }

        return Stack(
          children: _particles.map((particle) {
            return Positioned(
              left: particle.x * MediaQuery.of(context).size.width,
              bottom: particle.y * MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: (particle.y > 0.8) 
                    ? ((1.1 - particle.y) / 0.3).clamp(0.0, 1.0) * particle.opacity 
                    : particle.opacity,
                child: Transform.rotate(
                  angle: particle.rotation,
                  child: Transform.scale(
                    scale: particle.scale,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink.shade200,
                      size: 24,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _HeartParticle {
  double x;
  double y = 0.0;
  final double speed;
  final double scale;
  final double rotation;
  final double opacity;

  _HeartParticle({
    required this.x,
    required this.speed,
    required this.scale,
    required this.rotation,
    required this.opacity,
  });
}
