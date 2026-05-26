import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:formine/memories.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late AudioPlayer _audioPlayer = AudioPlayer();
  bool _showQuestions = false;
  bool _audioPlaying = false;
  int _currentQuestionIndex = 0;
  String? _currentImage;
  String? _currentAnswer;
  int _countdown = 3;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Do you know what my favorite thing in this world is?',
      'type': 'yes_no',
      'yesImage': 'assets/ammu/fav.jpg',
      'noImage': 'assets/ammu/fav.jpg',
      'yesAnswer': 'You',
      'noAnswer': 'You'
    },
    {
      'question': 'The most beautiful thing in you is ',
      'type': '🤨',
      '🤨': 'assets/ammu/smileee.jpg',
      'answer': 'Beautiful Smile',
    },
    {
      'question': 'Scariest part in my life?',
      'type': 'Dont_Know',
      'Dont_Know': 'assets/ammu/angry.jpg',
      'answer': 'Anger'
    },
    {
      'question': 'Your Cutest photo',
      'type': '😲',
      '😲': 'assets/ammu/cute.jpg',
      'answer': '😍',
    },
    {
      'question':
          'One surprise 😉 some one is Waiting for You to wish you happy birthday',
      'type': 'okay',
      'okayImage': 'assets/images/v.jpg',
      'answer': 'V'
    },
    {
      'question': 'Your Cutest photo',
      'type': '😲',
      '😲': 'assets/ammu/cute.jpg',
      'answer': '😍',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start countdown
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          _showQuestions = true;
        });
      }
    });
  }

Future<void> playAudioSequence() async {
    
    // Play each audio file sequentially
    for (int i = 1; i <= 4; i++) {
      String fileName = '$i.mp3';
      print("Inside playaudio: $fileName");
      _audioPlayer.play(AssetSource(fileName));
       
    }
  }

  void _nextQuestion(String answer) async {
    setState(() {
      var currentQuestion = _questions[_currentQuestionIndex];

      if (answer == 'yes' && currentQuestion['type'] == 'yes_no') {
        _currentImage = currentQuestion['yesImage'];
        _currentAnswer = currentQuestion['yesAnswer'];
      } else if (answer == 'no' && currentQuestion['type'] == 'yes_no') {
        _currentImage = currentQuestion['noImage'];
        _currentAnswer = currentQuestion['noAnswer'];
      } else if (answer == 'okay' && currentQuestion['type'] == 'okay') {
        _currentImage = currentQuestion['okayImage'];
        _currentAnswer = currentQuestion['answer'];
        if (_currentAnswer == 'V') {
          // Show popup with image and play audio
          _showPopup();
        }
      } else if (answer == '🤨' && currentQuestion['type'] == '🤨') {
        _currentImage = currentQuestion['🤨'];
        _currentAnswer = currentQuestion['answer'];
      } else if (answer == '😲' && currentQuestion['type'] == '😲') {
        _currentImage = currentQuestion['😲'];
        _currentAnswer = currentQuestion['answer'];
      } else if (answer == 'Dont_Know' &&
          currentQuestion['type'] == 'Dont_Know') {
        _currentImage = currentQuestion['Dont_Know'];
        _currentAnswer = currentQuestion['answer'];
      }

      _currentQuestionIndex++;
      if (_currentQuestionIndex >= _questions.length) {
        _currentQuestionIndex = 0; 
        // Loop back to the first question
        print("Looping back to the first question1111111111111111111111111111111111111");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MemoriesPage()),
        );
      }
    });
  }

  Future<void> _showPopup() async {
    // Play audio
    setState(() {
      _audioPlaying = true;
    });
    _audioPlayer.stop();

    // You need to ensure 'v.mp3' is in your assets and correctly referenced
    _audioPlayer.play(AssetSource('v.mp3'));

    // Show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Surprise!"),
        content: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/v.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
playAudioSequence();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MemoriesPage()),
              );
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/birthday.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content section
          Center(
            child: _showQuestions
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display the image if available
                      if (_currentImage != null)
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_currentImage!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20),
                      if (_currentAnswer != null)
                        Text(
                          _currentAnswer!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              _questions[_currentQuestionIndex]['question'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            if (_questions[_currentQuestionIndex]['type'] ==
                                'yes_no')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: _audioPlaying
                                        ? null // Disable button if audio is playing
                                        : () => _nextQuestion('yes'),
                                    child: Text('Yes'),
                                  ),
                                  ElevatedButton(
                                    onPressed: _audioPlaying
                                        ? null // Disable button if audio is playing
                                        : () => _nextQuestion('no'),
                                    child: Text('No'),
                                  ),
                                ],
                              )
                            else if (_questions[_currentQuestionIndex]
                                    ['type'] ==
                                '🤨')
                              ElevatedButton(
                                onPressed: _audioPlaying
                                    ? null // Disable button if audio is playing
                                    : () => _nextQuestion('🤨'),
                                child: Text('🤨'),
                              )
                            else if (_questions[_currentQuestionIndex]
                                    ['type'] ==
                                '😲')
                              ElevatedButton(
                                onPressed: _audioPlaying
                                    ? null // Disable button if audio is playing
                                    : () => _nextQuestion('😲'),
                                child: Text('😲'),
                              )
                            else if (_questions[_currentQuestionIndex]
                                    ['type'] ==
                                'Dont_Know')
                              ElevatedButton(
                                onPressed: _audioPlaying
                                    ? null // Disable button if audio is playing
                                    : () => _nextQuestion('Dont_Know'),
                                child: Text('Dont_Know'),
                              )
                            else
                              ElevatedButton(
                                onPressed: _audioPlaying
                                    ? null // Disable button if audio is playing
                                    : () => _nextQuestion('okay'),
                                child: Text('Okay'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      '$_countdown', // Display countdown value
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 4, 4),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
