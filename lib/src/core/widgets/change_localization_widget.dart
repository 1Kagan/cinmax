import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/core/cubit/app_language/app_language_cubit.dart';
import 'package:flutter_base/src/core/models/app_language_model/app_language.dart';
import 'package:flutter_base/src/core/models/app_language_model/language_model.dart';

final List<Language> languages = [
  Language('tr', 'Türkçe', '3710'),
  Language('en', 'English', '3241'),
  Language('it', 'Italiano', '3371'),
  Language('zh', '中文', '3886'),
];

class ChangeLocalizationWidget extends StatelessWidget {
  const ChangeLocalizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<AppLanguageCubit>();
    var selectedLanguage = localeProvider.getLocale.languageCode;

    int initialItemIndex =
        languages.indexWhere((lang) => lang.code == selectedLanguage);
    if (initialItemIndex == -1) {
      initialItemIndex = 0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.translate('language'),
          style: context.appTextTheme.xSmallRegular?.copyWith(
            fontSize: 13.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        InkWell(
          onTap: () {
            context.showContentBottomSheet(
              context: context,
              title: context.l10n.translate('language_choose'),
              onCloseButtonTap: (context) => Navigator.of(context).pop(),
              buttonLabel: context.l10n.translate('button_choose'),
              onButtonTap: (_) {
                localeProvider.setLocale(
                  AppLanguage(languageCode: selectedLanguage),
                );
                context.router.popForced();
              },
              content: SizedBox(
                height: 200.h,
                child: CupertinoPicker(
                  itemExtent: 40.h,
                  scrollController: FixedExtentScrollController(
                    initialItem: initialItemIndex,
                  ),
                  onSelectedItemChanged: (int index) {
                    selectedLanguage = languages[index].code;
                  },
                  children: languages.map((language) {
                    return Center(
                      child: Text(
                        language.name,
                        style: context.appTextTheme.body,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16).r,
            child: Text(
              languages
                  .firstWhere(
                    (lang) =>
                        lang.code == localeProvider.getLocale.languageCode,
                    orElse: () => languages.first,
                  )
                  .name,
              style: context.appTextTheme.xSmallRegular?.copyWith(
                color: AppColorTheme.infoTextLightGray,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
