import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Lists',
      body: ListView(
        children: [
          LinkListTile(
            icon: DLSAssets.icons.baseLogoDark.path,
            title: 'List Element with Icon',
          ),
          const LinkListTile(title: 'List Element'),
          AppCheckboxListTile(
            value: true,
            onChanged: (value) {},
            title: 'List Element',
          ),
          FormRadioListTile(
            groupValue: 1,
            value: 2,
            onChanged: (value) {},
            title: 'Idle Radio List Tile',
          ),
          FormRadioListTile(
            groupValue: 1,
            value: 1,
            onChanged: (value) {},
            title: 'Filled Radio List Tile',
          ),
          const AccordionListTile(
            title: 'List Element',
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac risus dapibus, commodo tellus at, ultricies nulla. Curabitur posuere enim eu felis.',
          ),
        ],
      ),
    );
  }
}
