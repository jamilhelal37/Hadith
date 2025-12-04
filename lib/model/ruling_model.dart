// lib/models/scholar.dart
class RulingModel {
  final int id;
  final String name;

  RulingModel({
    required this.id,
    required this.name,
  });

  factory RulingModel.fromJson(Map<String, dynamic> json) {
    return RulingModel(
      id: json['id'] as int,
      name: json['RulingText'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'RulingText': name,
    };
  }

  @override
  String toString() => 'ruling(id: $id, RulingText: $name)';
}