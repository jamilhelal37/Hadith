// lib/models/scholar.dart
class BookModel {
  final int id;
  final String name;

  BookModel({
    required this.id,
    required this.name,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'book(id: $id, book_name: $name)';
}