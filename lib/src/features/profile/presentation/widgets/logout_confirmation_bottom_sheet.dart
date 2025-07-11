import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/config/router/app_router_path.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutConfirmationBottomSheet extends StatelessWidget {
  const LogoutConfirmationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.bottomSheetTheme.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.translate('logout_confirmation'),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.router.pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: theme.colorScheme.outline),
                    foregroundColor: theme.colorScheme.onSurface,
                  ),
                  child: Text(context.l10n.translate('cancel')),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    context.router.pop();
                    // Logout işlemi tamamlanması için kısa bir bekleme
                    await Future.delayed(const Duration(milliseconds: 100));
                    // Login sayfasına yönlendir
                    if (context.mounted) {
                      context.router.replaceNamed(RouterPath.login);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(context.l10n.translate('logout')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
