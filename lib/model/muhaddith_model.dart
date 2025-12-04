// lib/models/scholar.dart
class MuhaddithModel {
  final int id;
  final String name;

  MuhaddithModel({
    required this.id,
    required this.name,
  });

  factory MuhaddithModel.fromJson(Map<String, dynamic> json) {
    return MuhaddithModel(
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
  String toString() => 'Muhaddith(id: $id, name: $name)';
}