class LoginException implements Exception {
  LoginException(this.message, {this.loginState = '0'});
  final String message;
  final String loginState;

  @override
  String toString() => '$message';
}