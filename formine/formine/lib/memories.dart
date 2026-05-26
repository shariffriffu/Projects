import 'package:flutter/material.dart';
import 'package:formine/cake.dart';

class MemoriesPage extends StatelessWidget {
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/ammu/best.jpg',
      'heading': 'Favorite pic',
    },
    {
      'image': 'assets/ammu/laove.jpg',
      'heading': 'My queen',
    },
    {
      'image': 'assets/ammu/laugh.jpg',
      'heading': '😍',
    },
    {
      'image': 'assets/ammu/love.jpg',
      'heading': 'Best Pic',
    },
    {
      'image': 'assets/ammu/cute.jpg',
      'heading': 'Cutest Photo',
    },
    {
      'image': 'assets/ammu/panishme.jpg',
      'heading': 'Cute punishment',
    },
    {
      'image': 'assets/ammu/smile.jpg',
      'heading': 'Laughter',
    },
    {
      'image': 'assets/ammu/teachme.jpg',
      'heading': 'Teacher',
    },
    {
      'image': 'assets/ammu/irritate.jpg',
      'heading': 'I love to irritate you 😂',
    },
    {
      'image': 'assets/ammu/from.jpg',
      'heading': 'From 🥰',
    },
    {
      'image': 'assets/ammu/2.jpg',
      'heading': 'Now 😘',
    },
    {
      'image': 'assets/ammu/6.jpg',
      'heading': 'Always Inshallah 💜',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),  // Spacer at the top
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_slides[index]['image']!),
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
                  Text(
                    _slides[index]['heading']!,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please slide the images out of 12",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(137, 0, 0, 0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BirthdayPage()),
                  );
                },
                child: Text('Click me after the last slide'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
