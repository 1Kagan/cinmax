import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/core_dls.dart';

class PasswordTextFieldScreen extends StatefulWidget {
  const PasswordTextFieldScreen({super.key});

  @override
  State<PasswordTextFieldScreen> createState() =>
      _PasswordTextFieldScreenState();
}

class _PasswordTextFieldScreenState extends State<PasswordTextFieldScreen> {
  late final FormGroup _fromGroup;

  static const _passwordInvisible = '_passwordInvisible';
  static const _passwordVisible = '_passwordVisible';
  static const _passwordError = '_passwordError';
  static const _passwordOnlyRead = '_passwordOnlyRead';

  @override
  void initState() {
    super.initState();

    _fromGroup = FormGroup({
      _passwordInvisible: FormControl<String>(
        value: "Input",
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
      ),
      _passwordVisible: FormControl<String>(
        value: "Input",
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
      ),
      _passwordError: FormControl<String>(
        value: "",
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
      ),
      _passwordOnlyRead: FormControl<String>(
        value: "Input",
        disabled: true,
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Password Text Field',
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            ReactiveForm(
              formGroup: _fromGroup,
              child: const AppReactivePasswordTextField(
                formControlName: _passwordInvisible,
                labelText: 'Password',
                helperText: 'Helper Text',
              ),
            ),
            const SizedBox(height: 32),
            ReactiveForm(
              formGroup: _fromGroup,
              child: const AppReactivePasswordTextField(
                formControlName: _passwordVisible,
                labelText: 'Password',
                obscureText: false,
                helperText: 'Helper Text',
              ),
            ),
            const SizedBox(height: 32),
            ReactiveForm(
              formGroup: _fromGroup,
              child: const AppReactivePasswordTextField(
                formControlName: _passwordError,
                labelText: 'Password',
                helperText: 'Helper Text',
              ),
            ),
            const SizedBox(height: 32),
            ReactiveForm(
              formGroup: _fromGroup,
              child: const AppReactivePasswordTextField(
                formControlName: _passwordOnlyRead,
                labelText: 'Password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
