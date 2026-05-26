import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../widgets/quotation_card.dart';

class QuotationsPage extends StatefulWidget {
  const QuotationsPage({super.key});

  @override
  State<QuotationsPage> createState() => _QuotationsPageState();
}

class _QuotationsPageState extends State<QuotationsPage> {
  final List<QuotationItem> _quotations = [
    QuotationItem(
      id: '1',
      eventType: 'Wedding Ceremonies',
      description: 'Complete wedding decoration services including mandap, stage, entrance, and all traditional elements for your special day.',
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=500',
      startingPrice: 25000,
      includes: [
        'Mandap/Altar Decoration',
        'Bridal Stage Setup',
        'Entrance Gate & Arch',
        'Guest Seating Arrangements',
        'Floral Decorations',
        'Lighting & Sound Setup',
        'Photography Backdrop',
        'Mehendi & Sangeet Setup',
        'Reception Decoration',
      ],
    ),
    QuotationItem(
      id: '2',
      eventType: 'Birthday Parties',
      description: 'Fun and vibrant birthday party decorations for all ages. From kids\' themed parties to elegant adult celebrations.',
      imageUrl: 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=500',
      startingPrice: 5000,
      includes: [
        'Balloon Decorations',
        'Themed Backdrops',
        'Birthday Banners',
        'Table Centerpieces',
        'Photo Booth Setup',
        'Cake Table Decoration',
        'Party Props & Games',
        'Character Decorations (Kids)',
      ],
    ),
    QuotationItem(
      id: '3',
      eventType: 'Anniversary Celebrations',
      description: 'Romantic and elegant decorations for anniversary celebrations. Create magical moments with our intimate setups.',
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=500',
      startingPrice: 8000,
      includes: [
        'Romantic Candle Arrangements',
        'Rose Petal Decorations',
        'Photo Memory Displays',
        'Heart-shaped Balloons',
        'Dinner Table Setup',
        'Mood Lighting',
        'Love Quote Displays',
        'Surprise Elements',
      ],
    ),
    QuotationItem(
      id: '4',
      eventType: 'Corporate Events',
      description: 'Professional and sophisticated decorations for corporate events, conferences, product launches, and business gatherings.',
      imageUrl: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=500',
      startingPrice: 15000,
      includes: [
        'Stage & Podium Setup',
        'Company Logo Branding',
        'Professional Lighting',
        'Audio-Visual Equipment',
        'Registration Desk Setup',
        'Networking Area Decoration',
        'Corporate Banners',
        'Welcome Signage',
      ],
    ),
    QuotationItem(
      id: '5',
      eventType: 'Festival Celebrations',
      description: 'Traditional and cultural decorations for festivals like Diwali, Holi, Navratri, Christmas, and other religious celebrations.',
      imageUrl: 'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?w=500',
      startingPrice: 10000,
      includes: [
        'Traditional Rangoli Designs',
        'Marigold Garland Decorations',
        'Diya & Candle Arrangements',
        'Cultural Backdrop Setup',
        'Religious Symbol Decorations',
        'Folk Art Elements',
        'Festival-specific Themes',
        'Traditional Music Setup',
      ],
    ),
    QuotationItem(
      id: '6',
      eventType: 'Baby Shower & Naming Ceremonies',
      description: 'Sweet and adorable decorations for welcoming new family members. Gentle themes and colors for these precious moments.',
      imageUrl: 'https://images.unsplash.com/photo-1544776527-42c3fae8e2e5?w=500',
      startingPrice: 7000,
      includes: [
        'Pastel Color Themes',
        'Baby-themed Decorations',
        'Balloon Arches',
        'Welcome Baby Banners',
        'Gift Table Setup',
        'Photo Props',
        'Gentle Lighting',
        'Ceremony Setup',
      ],
    ),
    QuotationItem(
      id: '7',
      eventType: 'Engagement Parties',
      description: 'Beautiful and elegant decorations for engagement ceremonies. Romantic themes to celebrate the beginning of a new journey.',
      imageUrl: 'https://images.unsplash.com/photo-1520854221256-17451cc331bf?w=500',
      startingPrice: 12000,
      includes: [
        'Ring Ceremony Setup',
        'Romantic Backdrop',
        'Floral Arrangements',
        'Engagement Photo Booth',
        'Couple Seating Area',
        'Guest Seating Decoration',
        'Lighting & Ambiance',
        'Celebration Props',
      ],
    ),
    QuotationItem(
      id: '8',
      eventType: 'Housewarming Ceremonies',
      description: 'Auspicious and beautiful decorations for new home celebrations. Traditional and modern elements to bless your new beginning.',
      imageUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=500',
      startingPrice: 6000,
      includes: [
        'Entrance Decoration',
        'Kalash & Toran Setup',
        'Puja Area Decoration',
        'Marigold Garlands',
        'Rangoli Designs',
        'Welcome Boards',
        'Traditional Elements',
        'Blessing Area Setup',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.request_quote,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Get Custom Quotations',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Choose your event type and get personalized quotations. Negotiate directly with our team for the best prices!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Call: +91 98765 43210',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Quotations grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.2,
            mainAxisSpacing: 16,
          ),
          itemCount: _quotations.length,
          itemBuilder: (context, index) {
            return QuotationCard(quotation: _quotations[index]);
          },
        ),
      ],
    );
  }
}