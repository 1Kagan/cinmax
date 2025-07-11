import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Icons',
      actions: const [_BlendModes()],
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemCount: DLSAssets.icons.values.length,
        itemBuilder: (ctx, index) {
          final icon = DLSAssets.icons.values[index];
          final iconName = icon.path.split('/').last;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon.svg(),
              Text(
                iconName,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BlendModes extends StatelessWidget {
  const _BlendModes();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          minHeight: 0.9.sh,
          maxHeight: 0.9.sh,
        ),
        builder: (context) => Scaffold(
          body: ListView(
            children: BlendMode.values
                .map(
                  (mode) => Column(
                    children: [
                      DLSAssets.icons.backSquare.svg(
                        colorFilter: ColorFilter.mode(
                          Colors.orange,
                          mode,
                        ),
                      ),
                      Text(mode.name),
                      const Divider(),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
      child: const Text('Blend Modes'),
    );
  }
}
