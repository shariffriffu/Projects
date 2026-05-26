import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VolumeControlScreen(),
    );
  }
}

class VolumeControlScreen extends StatefulWidget {
  @override
  _VolumeControlScreenState createState() => _VolumeControlScreenState();
}

class _VolumeControlScreenState extends State<VolumeControlScreen> {
  double _volume = 0.5;
  double _progress = 0.0;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    FlutterVolumeController.getVolume().then((volume) {
      setState(() {
        _volume = volume ?? 0.0;
      });
    });

    FlutterVolumeController.addListener((volume) {
      setState(() {
        _volume = volume;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    FlutterVolumeController.removeListener();
    super.dispose();
  }

  void _showDialog() {
    _startAudioPlayback();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Playing Audio'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: _progress,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        // Image.asset(
                        //   'assets/play_indicator.png', // Replace with your play icon image path
                        //   width: 100,
                        //   height: 100,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Volume:'),
                      Expanded(
                        child: Slider(
                          min: 0,
                          max: 1,
                          value: _volume,
                          onChanged: (value) {
                            setState(() {
                              _volume = value;
                              FlutterVolumeController.setVolume(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    _audioPlayer.stop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );

  }

  void _startAudioPlayback() async {
    try {
      await _audioPlayer.setUrl('http://202.144.156.178:8090/prbt/contentUpload/preview/55257.wav');
      _audioPlayer.play();
      _audioPlayer.playerStateStream.listen((playerState) {
        setState(() {
          _progress = _audioPlayer.position.inMilliseconds / _audioPlayer.duration!.inMilliseconds;
        });
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      body: Center(
        child: ElevatedButton(
          onPressed: _showDialog,
          child: const Text('Show Player'),
        ),
      ),
    );
  }
}
