class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final String email;
  final String photoUrl;
}
