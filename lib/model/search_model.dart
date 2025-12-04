class HadithModel {
  final List<Hadith> data;

  HadithModel({required this.data});

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      data: (json['data'] as List)
          .map((item) => Hadith.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class Hadith {
  final int? id; // Make nullable
  final String? hadithType; // Make nullable
  final String? hadithText; // Make nullable
  final int? hadithNumber; // Make nullable
  final Book? book; // Make nullable
  final Rawi? rawi; // Make nullable
  final Explaining? explaining;
  final Ruling? rulingOfMuhaddith; // Make nullable
  final Ruling? finalRuling; // Make nullable

  Hadith({
    this.id,
    this.hadithType,
    this.hadithText,
    this.hadithNumber,
    this.book,
    this.rawi,
    this.explaining,
    this.rulingOfMuhaddith,
    this.finalRuling,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'] as int?,
      hadithType: json['HadithType'] as String?,
      hadithText: json['HadithText'] as String?,
      hadithNumber: json['HadithNumber'] as int?,
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      rawi: json['rawi'] != null ? Rawi.fromJson(json['rawi']) : null,
      explaining: json['explaining'] != null
          ? Explaining.fromJson(json['explaining'])
          : null,
      rulingOfMuhaddith: json['ruling_of_muhaddith'] != null
          ? Ruling.fromJson(json['ruling_of_muhaddith'])
          : null,
      finalRuling: json['final_ruling'] != null
          ? Ruling.fromJson(json['final_ruling'])
          : null,
    );
  }

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

class Book {
  final int? id; // Make nullable
  final String? name; // Make nullable

  Book({this.id, this.name});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Rawi {
  final int? id; // Make nullable
  final String? name; // Make nullable

  Rawi({this.id, this.name});

  factory Rawi.fromJson(Map<String, dynamic> json) {
    return Rawi(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Explaining {
  final int? id; // Make nullable
  final String? text; // Make nullable

  Explaining({this.id, this.text});

  factory Explaining.fromJson(Map<String, dynamic> json) {
    return Explaining(
      id: json['id'] as int?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}

class Ruling {
  final int? id; // Make nullable
  final String? text; // Make nullable

  Ruling({this.id, this.text});

  factory Ruling.fromJson(Map<String, dynamic> json) {
    return Ruling(
      id: json['id'] as int?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}