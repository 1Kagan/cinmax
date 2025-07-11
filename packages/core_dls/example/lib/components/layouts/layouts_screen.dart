import 'package:example/components/layouts/bottom_sheet_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

import '../../constants/assets.gen.dart';

class LayoutsScreen extends StatefulWidget {
  const LayoutsScreen({super.key});

  @override
  State<LayoutsScreen> createState() => _LayoutsScreenState();
}

class _LayoutsScreenState extends State<LayoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Layouts',
      body: ListView(
        children: [
          LinkListTile(
            title: 'Main Node Layout',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainNodeLayout(body: FlutterLogo()),
              ),
            ),
          ),
          LinkListTile(
            title: 'SubPage Layout',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubPageLayout(
                  title: 'Wallet',
                  body: Container(
                    color: AppColorTheme.orange,
                    child: const Center(
                      child: Text('with  container'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          LinkListTile(
            title: 'SubPage Layout without title',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubPageLayout(
                  title: '',
                  removeTitle: true,
                  body: Container(
                    color: AppColorTheme.orange,
                    child: const Center(
                      child: Text('with  container \n& no title \n& default bodyPadding'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          LinkListTile(
            title: 'BottomSheet Layouts',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomSheetLayoutsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
