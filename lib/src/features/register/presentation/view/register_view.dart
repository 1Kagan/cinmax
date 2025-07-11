import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_bloc.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_event.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_state.dart';
import 'package:flutter_base/src/features/register/presentation/widgets/register_form.dart';
import 'package:flutter_base/src/features/auth/presentation/widgets/login_header.dart';
import 'package:flutter_base/src/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/src/injector.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MainNodeLayout(
        body: BlocProvider(
          create: (context) => injector<RegisterBloc>(),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.status == SubmissionStatus.success) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 48),
                        const SizedBox(height: 16),
                        Text(context.l10n
                            .translate('register_success_message')
                            .replaceAll(
                                '{name}', state.response?.user.name ?? '')),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          text: context.l10n.translate('login'),
                          onTap: () {
                            context.router.pushNamed('/login');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state.status == SubmissionStatus.failure) {
                context.showContentBottomSheet(
                  title: context.l10n.translate('register_failed'),
                  buttonLabel: context.l10n.translate('close'),
                  useButton: true,
                  onCloseButtonTap: (c) => Navigator.of(c).pop(),
                  onButtonTap: (c) => Navigator.of(c).pop(),
                  content: Column(
                    children: [
                      Text(state.submissionError ??
                          context.l10n.translate('unknown_error')),
                      16.verticalSpacingRadius,
                    ],
                  ),
                  context: context,
                );
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.l10n.translate('welcome'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    8.verticalSpacingRadius,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.l10n.translate('welcome_subtitle'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    23.verticalSpacingRadius,
                    const RegisterForm(),
                    32.verticalSpacingRadius,
                    const SocialLoginButtons(),
                    24.verticalSpacingRadius,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.translate('already_have_account'),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            context.router.popForced();
                          },
                          child: Text(
                            context.l10n.translate('login_now'),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    40.verticalSpacingRadius,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
