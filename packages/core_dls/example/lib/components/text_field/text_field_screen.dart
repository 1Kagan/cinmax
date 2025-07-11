import 'package:example/components/text_field/date_text_field_screen.dart';
import 'package:example/components/text_field/model/form_field.dart';
import 'package:example/components/text_field/password_text_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:core_dls/core_dls.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  late final FormGroup _fromGroup;

  @override
  void initState() {
    super.initState();

    _fromGroup = FormGroup({
      SampleFormField.firstName.name: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(50),
        ],
      ),
      SampleFormField.tckn.name: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(50),
        ],
      ),
      SampleFormField.phoneNumber.name: FormControl<PhoneNumber>(
        validators: [
          Validators.required,
          Validators.maxLength(10),
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Text Field',
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            LinkListTile(
              title: 'Date Text Field',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DateTextFieldScreen(),
                ),
              ),
            ),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
              readOnly: true,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              textEditingController: TextEditingController(text: 'Input Data'),
              onChange: (_) {},
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
              textEditingController: TextEditingController(text: 'Input Data'),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
              textEditingController: TextEditingController(text: 'Input Data'),
            ),
            const SizedBox(height: 16),
            Text(
              'Helper Text Field',
              style: context.appTextTheme.body,
            ),
            const SizedBox(height: 8),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
              textEditingController: TextEditingController(text: 'Input Data'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Label Text',
              onChange: (_) {},
              textEditingController: TextEditingController(text: 'Input Data'),
            ),
            const SizedBox(height: 16),
            Text(
              'Reactive Text Field',
              style: context.appTextTheme.body,
            ),
            const SizedBox(height: 8),
            ReactiveForm(
              formGroup: _fromGroup,
              child: AppReactiveTextField(
                formControlName: SampleFormField.firstName.name,
                labelText: 'Firstname',
                helperText: 'Helper Text',
                validationMessages: {
                  'required': (_) => 'please satisfy required rule',
                  'minLength': (_) => 'please satisfy minLength rule',
                },
              ),
            ),
            LinkListTile(
              title: 'Password Text Field',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasswordTextFieldScreen(),
                ),
              ),
            ),
            const ListTileDivider(),
            const ListTileDivider(),
          ],
        ),
      ),
    );
  }
}
