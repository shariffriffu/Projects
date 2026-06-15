import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:formine/cake.dart';

class MemoriesPage extends StatefulWidget {
  @override
  _MemoriesPageState createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage> {
  // Store the z-ordering indices. Tapping a card moves its index to the end of the list.
  List<int> _order = List.generate(8, (index) => index);

  // Polaroid Card data incorporating the new WhatsApp Images
  final List<Map<String, String>> _polaroidData = [
    {
      'image': 'assets/images/2.jpeg',
      'caption': 'Sweet Smile 😊',
      'note': 'Every time I look at this picture, my heart skips a beat. You have the most beautiful smile in the world, Begum. Never let it fade! ❤',
      'rotation': '-0.12',
      'x': '20',
      'y': '80',
    },
    {
      'image': 'assets/images/1.jpeg',
      'caption': 'Cutest Pose 📸',
      'note': 'You look so incredibly adorable in this one! I cannot help but fall in love with your cute expressions all over again. 😘',
      'rotation': '0.08',
      'x': '170',
      'y': '120',
    },
    {
      'image': 'assets/images/4.jpeg',
      'caption': 'Pure Joy ✨',
      'note': 'Your happiness is my absolute priority. I promise to keep doing whatever it takes to make you laugh like this forever. 😍',
      'rotation': '-0.06',
      'x': '30',
      'y': '260',
    },
    {
      'image': 'assets/images/3.jpeg',
      'caption': 'My Queen 👑',
      'note': 'You hold the key to my heart. May Allah bless you with endless laughter, peace, and success on your special day. 💜',
      'rotation': '0.15',
      'x': '180',
      'y': '280',
    },
    {
      'image': 'assets/images/6.jpeg',
      'caption': 'Unforgettable 🌸',
      'note': 'This gorgeous memory is forever etched in my heart. You are my dream come true and my biggest blessing. 💑',
      'rotation': '-0.08',
      'x': '15',
      'y': '420',
    },
    {
      'image': 'assets/images/8.jpeg',
      'caption': 'Lovely Eyes 👀',
      'note': 'I could gaze into your beautiful eyes for a lifetime and never get tired. You are absolutely perfect in every single way. 🥰',
      'rotation': '0.10',
      'x': '175',
      'y': '440',
    },
    {
      'image': 'assets/images/10.jpeg',
      'caption': 'Always & Forever ♾',
      'note': 'No matter where life takes us, my hand will always hold yours. Let\'s build the beautiful future we dreamed of. 💜',
      'rotation': '-0.14',
      'x': '100',
      'y': '200',
    },
    {
      'image': 'assets/images/11.jpeg',
      'caption': 'My Whole Heart ❤️',
      'note': 'On this birthday, even though I am virtual, my heart is completely with you. Saranghae, my love! Happy Birthday! 🎂✨',
      'rotation': '0.05',
      'x': '90',
      'y': '360',
    },
  ];

  // Store real-time offset positions for dragging
  List<Offset> _positions = [];

  @override
  void initState() {
    super.initState();
    // Initialize offsets from layout configurations
    for (var data in _polaroidData) {
      double dx = double.parse(data['x']!);
      double dy = double.parse(data['y']!);
      _positions.add(Offset(dx, dy));
    }
  }

  void _bringToFront(int index) {
    setState(() {
      _order.remove(index);
      _order.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred Cohesive Background image
          Image.asset(
            'assets/images/birthday.jpg',
            fit: BoxFit.cover,
          ),
          
          // Dark Wooden Scrapbook Desk Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color(0xFF1E1E1E).withOpacity(0.75), // Deep warm tone desk
            ),
          ),

          // Main Interactive Layout
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                
                // Title Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Our Scrapbook of Love 📖",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                
                const SizedBox(height: 6),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Drag cards around to arrange them. Tap to flip and read my handwritten letters! 💌",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                
                // Draggable Scrapbook Area
                Expanded(
                  child: Stack(
                    children: _order.map((index) {
                      final data = _polaroidData[index];
                      return PolaroidCard(
                        key: ValueKey<int>(index),
                        imagePath: data['image']!,
                        frontCaption: data['caption']!,
                        backDescription: data['note']!,
                        initialRotation: double.parse(data['rotation']!),
                        position: _positions[index],
                        onPositionChanged: (newPos) {
                          setState(() {
                            // Boundary restrictions to keep cards on desk
                            double minX = -20;
                            double maxX = screenSize.width - 150;
                            double minY = -20;
                            double maxY = screenSize.height - 400;
                            
                            _positions[index] = Offset(
                              newPos.dx.clamp(minX, maxX),
                              newPos.dy.clamp(minY, maxY),
                            );
                          });
                        },
                        onTap: () => _bringToFront(index),
                      );
                    }).toList(),
                  ),
                ),

                // Pulsing Gift Button at the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.pinkAccent,
                          Color(0xFFFF597B),
                          Colors.purpleAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.4),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BirthdayPage()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OPEN YOUR FINAL GIFT 🎁',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// Draggable, 3D Flipping Polaroid Card Widget
// -------------------------------------------------------------
class PolaroidCard extends StatefulWidget {
  final String imagePath;
  final String frontCaption;
  final String backDescription;
  final double initialRotation;
  final Offset position;
  final ValueChanged<Offset> onPositionChanged;
  final VoidCallback onTap;

  const PolaroidCard({
    Key? key,
    required this.imagePath,
    required this.frontCaption,
    required this.backDescription,
    required this.initialRotation,
    required this.position,
    required this.onPositionChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  _PolaroidCardState createState() => _PolaroidCardState();
}

class _PolaroidCardState extends State<PolaroidCard> {
  bool _isFlipped = false;

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: Transform.rotate(
        angle: widget.initialRotation,
        child: GestureDetector(
          onPanStart: (_) => widget.onTap(),
          onPanUpdate: (details) {
            widget.onTap();
            widget.onPositionChanged(widget.position + details.delta);
          },
          onTap: () {
            widget.onTap();
            _flipCard();
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: _isFlipped ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 600),
            builder: (context, val, child) {
              double rotationY = val * pi;
              // At 90 degrees rotation, switch layouts to front/back content
              bool showBack = rotationY > (pi / 2);

              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0016) // Perspective depth
                  ..rotateY(rotationY),
                alignment: Alignment.center,
                child: Container(
                  width: 155,
                  height: 205,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(2, 6),
                      ),
                    ],
                  ),
                  child: Transform(
                    // Flips back side text mirroring so it looks legible
                    transform: showBack ? Matrix4.rotationY(pi) : Matrix4.identity(),
                    alignment: Alignment.center,
                    child: showBack ? _buildCardBack() : _buildCardFront(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.frontCaption,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget _buildCardBack() {
    return Container(
      color: const Color(0xFFFFFEEB), // Vintage paper yellow
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_rounded, color: Colors.pink, size: 20),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                widget.backDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink.shade900,
                  fontSize: 11.5,
                  height: 1.35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
