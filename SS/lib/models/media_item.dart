class MediaItem {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final bool isVideo;
  final String? videoUrl;

  MediaItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isVideo = false,
    this.videoUrl,
  });
}

class OfferItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final List<String> features;

  OfferItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.features,
  });
}

class QuotationItem {
  final String id;
  final String eventType;
  final String description;
  final String imageUrl;
  final double startingPrice;
  final List<String> includes;

  QuotationItem({
    required this.id,
    required this.eventType,
    required this.description,
    required this.imageUrl,
    required this.startingPrice,
    required this.includes,
  });
}