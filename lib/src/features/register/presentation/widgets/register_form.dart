import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_bloc.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_event.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_state.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            AppTextField(
              hintText: context.l10n.translate('full_name'),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/user.svg',
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isLight
                      ? theme.colorScheme.onSurface
                      : const Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              ),
              errorText: state.nameError,
              onChange: (value) {
                context.read<RegisterBloc>().add(RegisterNameChanged(value));
              },
            ),
            13.verticalSpacingRadius,
            AppTextField(
              hintText: context.l10n.translate('email'),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/mail.svg',
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isLight
                      ? theme.colorScheme.onSurface
                      : const Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              ),
              errorText: state.emailError,
              onChange: (value) {
                context.read<RegisterBloc>().add(RegisterEmailChanged(value));
              },
            ),
            13.verticalSpacingRadius,
            AppTextField(
              hintText: context.l10n.translate('password'),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/lock.svg',
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isLight
                      ? theme.colorScheme.onSurface
                      : const Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              ),
              isPassword: true,
              errorText: state.passwordError,
              onChange: (value) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordChanged(value));
              },
            ),
            13.verticalSpacingRadius,
            AppTextField(
              hintText: context.l10n.translate('password_again'),
              prefixIcon: SvgPicture.asset(
                'assets/svgs/lock.svg',
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isLight
                      ? theme.colorScheme.onSurface
                      : const Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              ),
              isPassword: true,
              errorText: state.passwordAgainError,
              onChange: (value) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordAgainChanged(value));
              },
            ),
            16.verticalSpacingRadius,
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface.withOpacity(0.7)),
                children: [
                  TextSpan(
                      text: context.l10n.translate('user_agreement_part1')),
                  TextSpan(
                    text: context.l10n.translate('user_agreement_part2'),
                    style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                      text: context.l10n.translate('user_agreement_part3')),
                ],
              ),
            ),
            20.verticalSpacingRadius,
            PrimaryButton(
              onTap: () {
                context.read<RegisterBloc>().add(RegisterSubmitted(context));
              },
              isLoading: state.status == SubmissionStatus.loading,
              text: context.l10n.translate('register_now_button'),
            ),
          ],
        );
      },
    );
  }
}
