class UserLogout {
  UserLogout({
    required this.isSuccess,
  });

  factory UserLogout.fromJson(Map<String, dynamic> json) {
    return UserLogout(
      isSuccess: json['isSuccess'] as bool,
    );
  }

  final bool isSuccess;
}
