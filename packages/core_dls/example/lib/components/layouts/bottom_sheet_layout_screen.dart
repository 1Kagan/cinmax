import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class BottomSheetLayoutsScreen extends StatefulWidget {
  const BottomSheetLayoutsScreen({super.key});

  @override
  State<BottomSheetLayoutsScreen> createState() => _LayoutsScreenState();
}

class _LayoutsScreenState extends State<BottomSheetLayoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Bottom Sheet Layouts',
      body: ListView(
        children: [
          LinkListTile(
            title: 'BottomSheet Layout',
            onTap: () {
              context.showBottomSheetLayout(
                sheetLayout: const _FirstScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FirstScreen extends StatelessWidget {
  const _FirstScreen();

  @override
  Widget build(BuildContext context) {
    return BottomSheetLayout(
      onDoneTapped: Navigator.of(context, rootNavigator: true).pop,
      title: 'Fırst Screen',
      body: ElevatedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const _SecondScreen(),
          ),
        ),
        child: const Text('Next Sheet'),
      ),
    );
  }
}

class _SecondScreen extends StatelessWidget {
  const _SecondScreen();

  @override
  Widget build(BuildContext context) {
    return BottomSheetLayout(
      onBackTapped: Navigator.of(context).pop,
      onDoneTapped: Navigator.of(context, rootNavigator: true).pop,
      body: ElevatedButton(
        onPressed: Navigator.of(context, rootNavigator: true).pop,
        child: const Text('Dismiss Sheet'),
      ),
    );
  }
}
