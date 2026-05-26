import 'dart:async';
import 'package:flutter/material.dart';

class Giff extends StatefulWidget {
  const Giff({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Giff> {
  Timer? _timer;
  bool _showGif = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _showGif = true;
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  Widget _buildContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showGif = false;
        });
        _resetTimer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showGif
          ? FullScreenGif(
              gifUrl: 'http://support.tayanasoftware.com/images/SELFCARE.gif',
              onClose: () {
                setState(() {
                  _showGif = false;
                });
                _resetTimer();
              },
            )
          : _buildContent(),
    );
  }
}

class FullScreenGif extends StatelessWidget {
  final String gifUrl;
  final VoidCallback onClose;

  const FullScreenGif({
    Key? key,
    required this.gifUrl,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black,
        child: Center(
          child: Image.network(
            gifUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
