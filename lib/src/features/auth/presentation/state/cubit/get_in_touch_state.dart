part of 'get_in_touch_cubit.dart';

class FormState {
  FormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.isAccepted = false,
  });

  final String name;
  final String email;
  final String phone;
  final bool isAccepted;

  FormState copyWith({
    String? name,
    String? email,
    String? phone,
    bool? isAccepted,
  }) {
    return FormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }

  // Validation for name
  String? get nameError {
    if (name.isEmpty) return 'E';
    return null;
  }

  // Validation for email
  String? get emailError {
    if (email.isEmpty) return 'E';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'I';
    }
    return null;
  }

  // Validation for phone
  String? get phoneError {
    if (phone.isEmpty) return 'E';
    if (!RegExp(r'^\+?[0-9]{6,}$').hasMatch(phone)) return 'I';
    return null;
  }

  // Overall form validation
  bool get isFormValid =>
      nameError == null &&
      emailError == null &&
      phoneError == null &&
      isAccepted;
}
