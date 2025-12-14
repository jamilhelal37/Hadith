// advanced_search_model.dart
import 'dart:convert';

import 'package:untitled1/model/rawi_model.dart';
import 'package:untitled1/model/book_model.dart';

class AdvancedSearchRequest {
  final String? query;
  final int? muhaddithId;
  final int? rawiId;
  final int? subjectId;
  final int? bookId;
  final int? rulingId;
  final int page;
  String? type;
  final int limit;

  AdvancedSearchRequest({
    this.type,
    this.query,
    this.muhaddithId,
    this.rawiId,
    this.subjectId,
    this.bookId,
    this.rulingId,
    this.page = 1,
    this.limit = 20,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'page': page, 'limit': limit};

     if (query != null && query!.isNotEmpty) {
    map['text'] = query;
      }
      if (muhaddithId != null) {
    map['muhaddith'] = muhaddithId;
       }
       if (rawiId != null) {
    map['rawi'] = rawiId;
     }
     if (subjectId != null) {
    map['topic'] =subjectId;
      }
       if (bookId != null) {
    map['book'] = bookId;
       }
      if (rulingId != null) {
    map['rul'] = rulingId;
       }
    map['type'] = type;

    return map;
  }
}

class ExplainingModel {
  final int id;
  final String text;

  ExplainingModel({required this.id, required this.text});

  factory ExplainingModel.fromJson(Map<String, dynamic> json) {
    return ExplainingModel(
      id: _parseInt(json['id']) ?? 0,
      text: _parseString(json['text'] ?? ''),
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}

class RulingOfMuhaddithModel {
  final int id;
  final String text;

  RulingOfMuhaddithModel({required this.id, required this.text});

  factory RulingOfMuhaddithModel.fromJson(Map<String, dynamic> json) {
    return RulingOfMuhaddithModel(
      id: _parseInt(json['id']) ?? 0,
      text: _parseString(json['text']),
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}

class FinalRulingModel {
  final int id;
  final String text;

  FinalRulingModel({required this.id, required this.text});

  factory FinalRulingModel.fromJson(Map<String, dynamic> json) {
    return FinalRulingModel(
      id: _parseInt(json['id']) ?? 0,
      text: _parseString(json['text']),
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}

class AdvancedSearchResult {
  final int id;
  final String hadithType;
  final String hadithText;
  final int hadithNumber;
  final BookModel? book;
  final RawiModel? rawi;
  final ExplainingModel? explaining;
  final RulingOfMuhaddithModel? rulingOfMuhaddith;
  final FinalRulingModel? finalRuling;
  bool isFavorite; // Add this field

  AdvancedSearchResult({
    required this.id,
    required this.hadithType,
    required this.hadithText,
    required this.hadithNumber,
    this.book,
    this.rawi,
    this.explaining,
    this.rulingOfMuhaddith,
    this.finalRuling,
    this.isFavorite=false
  });

  factory AdvancedSearchResult.fromJson(Map<String, dynamic> json) {
    return AdvancedSearchResult(
      id: _parseInt(json['id']) ?? 0,
      hadithType: _parseString(json['HadithType']),
      hadithText: _parseString(json['HadithText']),
      hadithNumber: _parseInt(json['HadithNumber']) ?? 0,
      book: json['book'] != null ? BookModel.fromJson(json['book']) : null,
      rawi: json['rawi'] != null ? RawiModel.fromJson(json['rawi']) : null,
      explaining: json['explaining'] != null
          ? ExplainingModel.fromJson(json['explaining'])
          : null,
      rulingOfMuhaddith: json['ruling_of_muhaddith'] != null
          ? RulingOfMuhaddithModel.fromJson(json['ruling_of_muhaddith'])
          : null,
      finalRuling: json['final_ruling'] != null
          ? FinalRulingModel.fromJson(json['final_ruling'])
          : null,
      isFavorite: json['is_favorite'] ?? false, // Parse from API if available
    );
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return 0;
  }
}

class AdvancedSearchResponse {
  final List<AdvancedSearchResult> data;
  final int total;
  final int page;
  final int totalPages;
  final bool hasMore;

  AdvancedSearchResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.hasMore,
  });

  factory AdvancedSearchResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Debug: طباعة أنواع البيانات للتحقق
      // if (kDebugMode) {
      //   print('=== Parsing AdvancedSearchResponse ===');
      //   print('total: ${json['total']} (type: ${json['total']?.runtimeType})');
      //   print('page: ${json['page']} (type: ${json['page']?.runtimeType})');
      //   print('total_pages: ${json['total_pages']} (type: ${json['total_pages']?.runtimeType})');
      //   print('has_more: ${json['has_more']} (type: ${json['has_more']?.runtimeType})');
      // }

      // تحويل البيانات
      final List<AdvancedSearchResult> data = [];
      if (json['data'] != null && json['data'] is List) {
        for (var item in json['data']) {
          if (item is Map<String, dynamic>) {
            try {
              data.add(AdvancedSearchResult.fromJson(item));
            } catch (e) {
              // if (kDebugMode) {
              //   print('Error parsing search result item: $e');
              //   print('Item data: $item');
              // }
            }
          }
        }
      }

      return AdvancedSearchResponse(
        data: data,
        total: _parseInt(json['total']) ?? 0,
        page: _parseInt(json['page']) ?? 1,
        totalPages: _parseInt(json['total_pages']) ?? 1,
        hasMore: _parseBool(json['has_more']),
      );
    } catch (e, stackTrace) {
      // if (kDebugMode) {
      //   print('Error in AdvancedSearchResponse.fromJson: $e');
      //   print('Stack trace: $stackTrace');
      //   print('JSON data: $json');
      // }
      // إرجاع رد فارغ في حالة الخطأ
      return AdvancedSearchResponse(
        data: [],
        total: 0,
        page: 1,
        totalPages: 1,
        hasMore: false,
      );
    }
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      // محاولة تحويل السلسلة إلى int
      return int.tryParse(value);
    }
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    return null;
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final lowerValue = value.toLowerCase();
      return lowerValue == 'true' || lowerValue == '1';
    }
    if (value is int) return value == 1;
    if (value is double) return value == 1.0;
    return false;
  }

  // دالة لتحويل النموذج إلى JSON إذا احتجتها
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
      'page': page,
      'total_pages': totalPages,
      'has_more': hasMore,
    };
  }
}

// إضافة دالة toJson للـ AdvancedSearchResult إذا لم تكن موجودة
extension AdvancedSearchResultExtension on AdvancedSearchResult {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'HadithType': hadithType,
      'HadithText': hadithText,
      'HadithNumber': hadithNumber,
      'book': book?.toJson(),
      'rawi': rawi?.toJson(),
      'explaining': explaining?.toJson(),
      'ruling_of_muhaddith': rulingOfMuhaddith?.toJson(),
      'final_ruling': finalRuling?.toJson(),
    };
  }
}

// إضافة دوال toJson للنماذج الأخرى
extension ExplainingModelExtension on ExplainingModel {
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}

extension RulingOfMuhaddithModelExtension on RulingOfMuhaddithModel {
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}

extension FinalRulingModelExtension on FinalRulingModel {
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
