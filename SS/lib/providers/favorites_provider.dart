import 'package:flutter/foundation.dart';
import '../models/media_item.dart';

class FavoritesProvider {
  static final List<MediaItem> _favorites = [];

  static List<MediaItem> get favorites => List.unmodifiable(_favorites);

  static bool isFavorite(String mediaId) {
    return _favorites.any((item) => item.id == mediaId);
  }

  static void toggleFavorite(MediaItem item) {
    final existingIndex = _favorites.indexWhere((fav) => fav.id == item.id);
    
    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(item);
    }
  }

  static void removeFavorite(String mediaId) {
    _favorites.removeWhere((item) => item.id == mediaId);
  }

  static void clearAll() {
    _favorites.clear();
  }
}