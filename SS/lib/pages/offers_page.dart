import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../widgets/offer_card.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final List<OfferItem> _offers = [
    OfferItem(
      id: '1',
      title: 'Wedding Premium Package',
      description: 'Complete wedding decoration including mandap, stage, entrance, and guest seating arrangements. Perfect for your dream wedding! 💒',
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=500',
      price: 45000,
      originalPrice: 60000,
      features: [
        'Mandap Decoration',
        'Stage Setup',
        'Entrance Arch',
        'Guest Seating',
        'Lighting Arrangements',
        'Fresh Flowers',
        'Photography Backdrop',
        'Free Setup & Cleanup'
      ],
    ),
    OfferItem(
      id: '2',
      title: 'Birthday Celebration Special',
      description: 'Fun and colorful birthday decorations that will make your celebration memorable! Perfect for all ages. 🎂🎈',
      imageUrl: 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=500',
      price: 8500,
      originalPrice: 12000,
      features: [
        'Balloon Arrangements',
        'Birthday Banners',
        'Table Decorations',
        'Photo Booth Setup',
        'Cake Table Decoration',
        'Color Themes Available',
        'Party Props Included'
      ],
    ),
    OfferItem(
      id: '3',
      title: 'Corporate Event Package',
      description: 'Professional and elegant decorations for your corporate events, conferences, and business gatherings. 🏢✨',
      imageUrl: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=500',
      price: 25000,
      originalPrice: 35000,
      features: [
        'Stage & Podium Setup',
        'Company Branding',
        'Audio Visual Setup',
        'Professional Lighting',
        'Welcome Signage',
        'Registration Desk',
        'Networking Area Setup'
      ],
    ),
    OfferItem(
      id: '4',
      title: 'Festival Decoration Special',
      description: 'Traditional and vibrant festival decorations for Diwali, Holi, Navratri and other celebrations! 🎊🪔',
      imageUrl: 'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?w=500',
      price: 15000,
      originalPrice: 20000,
      features: [
        'Traditional Rangoli',
        'Marigold Garlands',
        'Diya Arrangements',
        'Cultural Backdrops',
        'Religious Setup',
        'Folk Art Elements',
        'Festive Lighting'
      ],
    ),
    OfferItem(
      id: '5',
      title: 'Anniversary Romance Package',
      description: 'Intimate and romantic decorations for anniversary celebrations. Create magical moments! 💕🌹',
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=500',
      price: 12000,
      originalPrice: 16000,
      features: [
        'Rose Petals & Candles',
        'Romantic Lighting',
        'Heart-shaped Balloons',
        'Photo Memory Wall',
        'Dinner Table Setup',
        'Love Letter Displays',
        'Surprise Elements'
      ],
    ),
    OfferItem(
      id: '6',
      title: 'Garden Party Deluxe',
      description: 'Fresh outdoor decorations with natural elements, perfect for garden parties and outdoor events! 🌿🌺',
      imageUrl: 'https://images.unsplash.com/photo-1505236858219-8359eb29e329?w=500',
      price: 18000,
      originalPrice: 24000,
      features: [
        'Natural Plant Arrangements',
        'Fairy Light Canopy',
        'Wooden Setup Elements',
        'Garden Pathway Decor',
        'Outdoor Seating',
        'Weather-Resistant Setup',
        'Nature-Themed Props'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_offer,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offers & Packages',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Limited time deals on our premium decoration services',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Offers list
          ...List.generate(_offers.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: OfferCard(offer: _offers[index]),
            );
          }),
        ],
      ),
    );
  }
}