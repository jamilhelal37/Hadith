// lib/models/scholar.dart
class AboutMuhaddithModel {
  final String? name;
  final String ?about;

  AboutMuhaddithModel({
    required this.name,
    required this.about,
  });

  factory AboutMuhaddithModel.fromJson(Map<String, dynamic> json) {
    return AboutMuhaddithModel(
      name: json['name'] as String,
      about: json['about'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'about': about,
    };
  }

  @override
  String toString() => 'Subject( name: $name,about: $about)';
}