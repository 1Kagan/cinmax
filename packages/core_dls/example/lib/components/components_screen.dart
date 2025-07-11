import 'package:example/components/avatars/avatars_screen.dart';
import 'package:example/components/cards/badge_tile_screen/badge_tile_screen.dart';
import 'package:example/components/cards/onboarding_screen/onboarding_screen.dart';
import 'package:example/components/cards/profile/profile_screen.dart';
import 'package:example/components/drop_down/drop_down_screen.dart';
import 'package:example/components/feedbacks/bottom_sheet/bottom_sheet_screen.dart';
import 'package:example/components/feedbacks/toasts/toast_messages.dart';
import 'package:example/components/lists/lists.dart';
import 'package:example/components/misc/chips_screen.dart';
import 'package:example/components/text_field/text_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';
import 'app_bars/app_bars_screen.dart';
import 'buttons/buttons_screen.dart';
import 'layouts/layouts_screen.dart';

class ComponentsScreen extends StatelessWidget {
  const ComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Component Gallery',
      body: ListView(
        children: [
          _pushButton(
            'Layouts',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutsScreen(),
              ),
            ),
          ),
          _pushButton(
            'Buttons',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ButtonsScreen(),
              ),
            ),
          ),
          _pushButton(
            'AppBars',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppbarsScreen(),
              ),
            ),
          ),
          _pushButton(
            'Bottom Sheet',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomSheetScreen(),
              ),
            ),
          ),
          _pushButton(
            'Lists',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListsScreen(),
              ),
            ),
          ),
          _pushButton(
            'Text Box Dropdown',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DropDownScreen(),
              ),
            ),
          ),
          _pushButton(
            'Toasts',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ToastMessages(),
              ),
            ),
          ),
          _pushButton(
            'Profile',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            ),
          ),
          _pushButton(
            'Onboarding',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ),
            ),
          ),
          _pushButton(
            'Badge Tile',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BadgeTileScreen(),
              ),
            ),
          ),
          _pushButton(
            'Chips',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChipsScreen(),
              ),
            ),
          ),
          _pushButton(
            'Text Field',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TextFieldScreen(),
              ),
            ),
          ),
          _pushButton(
            'Avatars',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AvatarsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pushButton(
    String label,
    VoidCallback onTap,
  ) =>
      LinkListTile(
        title: label,
        onTap: onTap,
      );
}
