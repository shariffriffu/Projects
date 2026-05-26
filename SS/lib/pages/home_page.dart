import 'package:flutter/material.dart';
import '../providers/favorites_provider.dart';
import '../models/media_item.dart';
import '../widgets/media_post_card.dart';
import '../widgets/full_screen_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MediaItem> _posts = [
    MediaItem(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=500',
      title: 'Elegant Wedding Decoration',
      description: 'Beautiful floral arrangements and lighting for a perfect wedding celebration 💐✨',
    ),
    MediaItem(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=500',
      title: 'Birthday Party Setup',
      description: 'Colorful and vibrant birthday decorations that made the day extra special 🎂🎈',
    ),
    MediaItem(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=500',
      title: 'Corporate Event Decoration',
      description: 'Professional and sophisticated setup for corporate gatherings 🏢🎊',
    ),
    MediaItem(
      id: '4',
      imageUrl: 'https://images.unsplash.com/photo-1505236858219-8359eb29e329?w=500',
      title: 'Garden Party Theme',
      description: 'Fresh outdoor decoration with natural elements and fairy lights 🌿💡',
    ),
    MediaItem(
      id: '5',
      imageUrl: 'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?w=500',
      title: 'Traditional Festival Setup',
      description: 'Cultural decorations with traditional colors and patterns 🪔🎨',
    ),
    MediaItem(
      id: '6',
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=500',
      title: 'Anniversary Celebration',
      description: 'Romantic setup with roses and candles for a memorable anniversary 🌹🕯️',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return MediaPostCard(
            mediaItem: post,
            onTap: () => _openFullScreenViewer(context, post),
          );
        },
      ),
    );
  }

  void _openFullScreenViewer(BuildContext context, MediaItem mediaItem) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullScreenViewer(mediaItem: mediaItem),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}