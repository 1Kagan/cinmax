import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/core/cubit/app_language/app_language_cubit.dart';
import 'package:flutter_base/src/core/models/app_language_model/app_language.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelectionBottomSheet extends StatelessWidget {
  const LanguageSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.watch<AppLanguageCubit>();
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
                  context.l10n.translate('change_language'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    RadioListTile<String>(
                      title: Text(context.l10n.translate('english')),
                      value: 'en',
                      groupValue: languageCubit.state.appLanguage.languageCode,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<AppLanguageCubit>()
                              .setLocale(AppLanguage(languageCode: value));
                        }
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(context.l10n.translate('turkish')),
                      value: 'tr',
                      groupValue: languageCubit.state.appLanguage.languageCode,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<AppLanguageCubit>()
                              .setLocale(AppLanguage(languageCode: value));
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
