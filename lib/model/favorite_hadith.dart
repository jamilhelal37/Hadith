// favorite_model.dart
import 'advanced_search_model.dart';

class FavoriteHadithModel {
  final int id;
  final int hadithId;
  final DateTime createdAt;
  final AdvancedSearchResult? hadithData; // Optional: full hadith data

  FavoriteHadithModel({
    required this.id,
    required this.hadithId,
    required this.createdAt,
    this.hadithData,
  });

  factory FavoriteHadithModel.fromJson(Map<String, dynamic> json) {
    return FavoriteHadithModel(
      id: _parseInt(json['id']) ?? 0,
      hadithId: _parseInt(json['hadith_id']) ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      hadithData: json['hadith'] != null
          ? AdvancedSearchResult.fromJson(json['hadith'])
          : null,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class FavoriteResponse {
  final List<FavoriteHadithModel> favorites;
  final int total;
  final int page;
  final bool hasMore;

  FavoriteResponse({
    required this.favorites,
    required this.total,
    required this.page,
    required this.hasMore,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    final List<FavoriteHadithModel> favorites = [];

    if (json['data'] != null && json['data'] is List) {
      for (var item in json['data']) {
        favorites.add(FavoriteHadithModel.fromJson(item));
      }
    }

    return FavoriteResponse(
      favorites: favorites,
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      hasMore: json['has_more'] ?? false,
    );
  }
}