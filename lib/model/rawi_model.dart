// lib/models/scholar.dart
class RawiModel {
  final int id;
  final String name;

  RawiModel({
    required this.id,
    required this.name,
  });

  factory RawiModel.fromJson(Map<String, dynamic> json) {
    return RawiModel(
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
  String toString() => 'Rawi(id: $id, name: $name)';
}