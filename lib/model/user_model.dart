class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String usertype;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.usertype,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      usertype: json['usertype'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'usertype': usertype,
    };
  }
}