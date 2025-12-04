// lib/models/scholar.dart
class SubjectModel {
  final int id;
  final String name;

  SubjectModel({
    required this.id,
    required this.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] as int,
      name: json['TopicName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'TopicName': name,
    };
  }

  @override
  String toString() => 'Subject(id: $id, name: $name)';
}