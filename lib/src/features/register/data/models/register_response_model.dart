class RegisterResponseModel {
  final String token;
  final String id;
  final String name;
  final String email;

  RegisterResponseModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return RegisterResponseModel(
      token: data['token'] as String,
      id: data['id'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
    );
  }
}

class RegisterUserModel {
  final String id;
  final String name;
  final String email;

  RegisterUserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
