// advanced_search_model.dart

import 'package:untitled1/model/rawi_model.dart';

import 'book_model.dart';

class AdvancedSearchRequest {
  final String? query;
  final int? muhaddithId;
  final int? rawiId;
  final int? subjectId;
  final int? bookId;
  final int? rulingId;
  final int page;
  final int limit;

  AdvancedSearchRequest({
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
    final map = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (query != null && query!.isNotEmpty) {
      map['query'] = query;
    }
    if (muhaddithId != null) {
      map['muhaddith_id'] = muhaddithId;
    }
    if (rawiId != null) {
      map['rawi_id'] = rawiId;
    }
    if (subjectId != null) {
      map['subject_id'] = subjectId;
    }
    if (bookId != null) {
      map['book_id'] = bookId;
    }
    if (rulingId != null) {
      map['ruling_id'] = rulingId;
    }

    return map;
  }
}

class ExplainingModel {
  final int id;
  final String text;

  ExplainingModel({
    required this.id,
    required this.text,
  });

  factory ExplainingModel.fromJson(Map<String, dynamic> json) {
    return ExplainingModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}

class RulingOfMuhaddithModel {
  final int id;
  final String text;

  RulingOfMuhaddithModel({
    required this.id,
    required this.text,
  });

  factory RulingOfMuhaddithModel.fromJson(Map<String, dynamic> json) {
    return RulingOfMuhaddithModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}

class FinalRulingModel {
  final int id;
  final String text;

  FinalRulingModel({
    required this.id,
    required this.text,
  });

  factory FinalRulingModel.fromJson(Map<String, dynamic> json) {
    return FinalRulingModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
    );
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
  });

  factory AdvancedSearchResult.fromJson(Map<String, dynamic> json) {
    return AdvancedSearchResult(
      id: json['id'] ?? 0,
      hadithType: json['HadithType'] ?? '',
      hadithText: json['HadithText'] ?? '',
      hadithNumber: json['HadithNumber'] ?? 0,
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
    );
  }
}

class AdvancedSearchResponse {
  final List<AdvancedSearchResult> data;
  final int? total;
  final int? page;
  final int? totalPages;
  final bool? hasMore;

  AdvancedSearchResponse({
    required this.data,
    this.total,
    this.page,
    this.totalPages,
    this.hasMore,
  });

  factory AdvancedSearchResponse.fromJson(Map<String, dynamic> json) {
    final data = <AdvancedSearchResult>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(AdvancedSearchResult.fromJson(v));
      });
    }

    return AdvancedSearchResponse(
      data: data,
      total: json['total'],
      page: json['page'],
      totalPages: json['total_pages'],
      hasMore: json['has_more'],
    );
  }
}