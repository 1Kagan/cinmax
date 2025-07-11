import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/core/widgets/support_helper.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_event.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            AppTextField(
              hintText: context.l10n.translate('email'),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SvgPicture.asset(
                  'assets/svgs/mail.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFFFFF)
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              onChange: (value) {
                context.read<AuthBloc>().add(AuthEmailChanged(value));
              },
              errorText: state.emailError,
            ),
            16.verticalSpacingRadius,
            AppTextField(
              hintText: context.l10n.translate('password'),
              isPassword: true,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SvgPicture.asset(
                  'assets/svgs/lock.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFFFFF)
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              onChange: (value) {
                context.read<AuthBloc>().add(AuthPasswordChanged(value));
              },
              errorText: state.passwordError,
            ),
            16.verticalSpacingRadius,
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: SupportHelper.openForgotPasswordUrl,
                child: Text(
                  context.l10n.translate('forgot_password'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            24.verticalSpacingRadius,
            PrimaryButton(
              text: context.l10n.translate('login'),
              isLoading: state.status == AuthStatus.loading,
              onTap: () {
                context.read<AuthBloc>().add(AuthSubmitted(context));
              },
            ),
          ],
        );
      },
    );
  }
}
