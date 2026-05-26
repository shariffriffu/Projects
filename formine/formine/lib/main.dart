// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:formine/questions.dart';

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
    with SingleTickerProviderStateMixin {
  late ConfettiController _controllerCenter;
  late AnimationController _animationController;
  late Timer _backgroundTimer;
  int _currentImageIndex = 0;
  int _currentMessageIndex = 0;
  late PageController _pageController;
  List<String> _backgroundImages = [
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
    // Add more image paths as needed
  ];
  List<String> ammu = [];
  List<String> _messages = [
    'my love 🥰!\n From the moment we met, you’ve brought an unparalleled joy and warmth into my life 😍. \nYour smile and support that makes me to fight the darkest days, and I am endlessly grateful for your presence 😘.',
    'You are not just my lover 😘, \nbut my best friend😍, confidante, incredible partner and my \n future wife🥰. Your kindness, compassion, and endless patience inspire me daily. \n Your ability to see the best in every situation and your contagious optimism make you truly remarkable🥰.',
    'Happy birthday by love ❤❤, \n I wish you all the happiness and fulfillment your heart desires. \n You are the love of my life, and I promise to cherish, \n support, and love you more with each passing day. \n Enjoy your special day, knowing you are deeply loved and appreciated.',
    'on this day i may not be there in front of you but,\n  i am always present in your heart and i am here vertually i wanna say that \n "Saranghae💜" ',
    'thank you for handling me and keep guiding me like always ❤, help me to build a beautifull future that we dreamed for Us ❤',
    'Happy Birthday, my love!'
  ];

  late AudioPlayer _audioPlayer = AudioPlayer();
  late AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    _controllerCenter.addListener(() {
      if (_controllerCenter.state == ConfettiControllerState.stopped) {
        _controllerCenter.play();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _backgroundTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });

    _initAudioPlayer();

    _pageController = PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == _backgroundImages.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _animationController.dispose();
    _backgroundTimer.cancel();
    _pageController.dispose();
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
    print("Inside stopppppppppppppppppppppppp ");
    _audioPlayer.stop();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Completion Check'),
          content: Text('Have you completed the slides?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                stopplay();
 Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QuestionsPage()),
        );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                _showAlertMessage();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMusicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Music Control'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _playMusic,
                iconSize: 48.0,
                icon: Icon(Icons.play_arrow),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: _pauseMusic,
                iconSize: 48.0,
                icon: Icon(Icons.pause),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                stopplay();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlertMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Please go and read the messages.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
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
      _currentMessageIndex = 0; // Reset index or handle as per your logic
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: Container(
              key: ValueKey<int>(_currentImageIndex),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_backgroundImages[_currentImageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content stacked on top of the image
          Positioned(
            top: 360,
            left: 0,
            right: 0,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Center confetti
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ConfettiWidget(
                        confettiController: _controllerCenter,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                        emissionFrequency: 0.01,
                        numberOfParticles: 100,
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple
                        ],
                      ),
                    ],
                  ),
                ),
                // Text box with message
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _messages[_currentMessageIndex],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Next message button (constant position)
          Positioned(
            bottom: 20,
            left: 20,
            child: RawMaterialButton(
              onPressed: () {
               _incrementMessageIndex();
              },
              elevation: 2.0,
              fillColor: Color.fromARGB(255, 245, 237, 244),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.purple,
                size: 30.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 240,
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  stopplay();
                });
              },
              elevation: 2.0,
              fillColor: Color.fromARGB(255, 245, 237, 244),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              child: Icon(
                Icons.pause,
                color: const Color.fromARGB(255, 15, 4, 17),
                size: 30.0,
              ),
            ),
          ),

          // Completion check button
          IconButton(
            onPressed: _showCompletionDialog,
            icon: Icon(Icons.check_circle),
            color: Color.fromARGB(255, 235, 235, 235),
            iconSize: 60,
          ),
        ],
      ),
    );
  }
}

class HeartShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width * 0.6; // Scale down the width
    final height = size.height * 0.6; // Scale down the height
    final offsetX = size.width * 0.2; // Center the smaller heart horizontally
    final offsetY = size.height * 0.2; // Center the smaller heart vertically

    path.moveTo(width / 2 + offsetX, height / 4 + offsetY);
    path.cubicTo(5 * width / 14 + offsetX, 0 + offsetY, 0 + offsetX,
        height / 6 + offsetY, width / 28 + offsetX, 2 * height / 5 + offsetY);
    path.cubicTo(
        width / 14 + offsetX,
        2 * height / 3 + offsetY,
        3 * width / 7 + offsetX,
        5 * height / 6 + offsetY,
        width / 2 + offsetX,
        height + offsetY);
    path.cubicTo(
        4 * width / 7 + offsetX,
        5 * height / 6 + offsetY,
        13 * width / 14 + offsetX,
        2 * height / 3 + offsetY,
        27 * width / 28 + offsetX,
        2 * height / 5 + offsetY);
    path.cubicTo(
        width + offsetX,
        height / 6 + offsetY,
        9 * width / 14 + offsetX,
        0 + offsetY,
        width / 2 + offsetX,
        height / 4 + offsetY);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
