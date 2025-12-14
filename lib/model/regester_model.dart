class RegesterModel {
  final String email;
  final String password;
  final String name;
  final String gender;
  final String date;

  RegesterModel({
    required this.email,
    required this.password,
    required this.name,
    required this.gender,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": "x",
      "username": name,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "gender": gender,
      "birth_date": date,
    };
  }
}
