import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/theme/app_theme.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_event.dart';
import 'package:flutter_base/src/features/profile/presentation/widgets/language_selection_bottom_sheet.dart';
import 'package:flutter_base/src/features/profile/presentation/widgets/logout_confirmation_bottom_sheet.dart';
import 'package:flutter_base/src/features/profile/presentation/widgets/theme_selection_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          Theme.of(context).extension<CustomThemeExtension>()!.drawerBodyColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 150),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(context.l10n.translate('change_theme')),
            onTap: () {
              context.router.pop();
              showModalBottomSheet(
                context: context,
                builder: (context) => const ThemeSelectionBottomSheet(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.translate('change_language')),
            onTap: () {
              context.router.pop();
              showModalBottomSheet(
                context: context,
                builder: (context) => const LanguageSelectionBottomSheet(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.l10n.translate('logout')),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => const LogoutConfirmationBottomSheet(),
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
