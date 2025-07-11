import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/login_usecase.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_event.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_base/src/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter_base/src/features/auth/presentation/widgets/login_header.dart';
import 'package:flutter_base/src/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final subTitle =
        context.l10n.translate('login_screen_member_login_subtitle');
    return BlocProvider(
      create: (context) => AuthBloc(
        injector<LoginUseCase>(),
        injector<LogoutUseCase>(),
      ),
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.failure) {
              context.showContentBottomSheet(
                title: context.l10n.translate('login_failed'),
                buttonLabel: context.l10n.translate('close'),
                useButton: true,
                onCloseButtonTap: (c) => Navigator.of(c).pop(),
                onButtonTap: (c) => Navigator.of(c).pop(),
                content: Column(
                  children: [
                    Text(
                      state.submissionError ??
                          context.l10n.translate('unknown_error'),
                    ),
                    16.verticalSpacingRadius,
                  ],
                ),
                context: context,
              );
            } else if (state.status == AuthStatus.success) {
              context.router.pushNamed('/home');
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Column(
                children: [
                  280.verticalSpacingRadius,
                  LoginHeader(
                    title: context.l10n.translate('login_screen_member_login'),
                    subtitle: subTitle != 'login_screen_member_login_subtitle'
                        ? subTitle
                        : '',
                  ),
                  23.verticalSpacingRadius,
                  const LoginForm(),
                  35.verticalSpacingRadius,
                  const SocialLoginButtons(),
                  24.verticalSpacingRadius,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.translate('dont_have_account'),
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
                          context.router.pushNamed('/register');
                        },
                        child: Text(
                          context.l10n.translate('register_now'),
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
    );
  }
}
