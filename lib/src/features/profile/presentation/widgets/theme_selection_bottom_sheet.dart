import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/core/cubit/app_theme/app_theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSelectionBottomSheet extends StatelessWidget {
  const ThemeSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<AppThemeCubit>();
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.l10n.translate('change_theme'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(context.l10n.translate('light_theme')),
                      value: ThemeMode.light,
                      groupValue: themeCubit.state.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppThemeCubit>().setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(context.l10n.translate('dark_theme')),
                      value: ThemeMode.dark,
                      groupValue: themeCubit.state.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppThemeCubit>().setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(context.l10n.translate('system_theme')),
                      value: ThemeMode.system,
                      groupValue: themeCubit.state.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppThemeCubit>().setTheme(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
