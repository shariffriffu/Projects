import 'package:flutter/material.dart';

class AnimatedGifWidget extends StatefulWidget {
  @override
  _AnimatedGifWidgetState createState() => _AnimatedGifWidgetState();
}

class _AnimatedGifWidgetState extends State<AnimatedGifWidget> {
  bool isScreenSaverActive = false;


 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated image at the bottom center
        Visibility(
          visible: !isScreenSaverActive,
          
            child: SizedBox(
              width: 350,
              height: 250,
              child: Align(
               
                child: SizedBox(
                  height: 350,
                  width: 350,
                  child: Image.network(
                    'http://support.tayanasoftware.com/images/SELFCARE.gif',
                   
                  ),
                ),
              ),
            ),
          
        ),
        // Animated image at the center of the screen
       
          
      ],
    );
  }
}
