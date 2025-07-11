import 'package:core_dls/core_dls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

void showWarningBottomSheet(
  BuildContext context,
) {
  context.showContentBottomSheet(
    title: context.l10n.translate('warning_bottomsheet'),
    buttonLabel: context.l10n.translate('contact_us_contact_us'),
    onCloseButtonTap: (context) => Navigator.of(context).pop(),
    onButtonTap: (_) {
      openContactWebsite('https://example.com/contact-us');
    },
    content: Column(
      children: [
        12.verticalSpacingRadius,
        Text(
          context.l10n.translate('auth_waring_info_text'),
          style: context.appTextTheme.body,
        ),
        12.verticalSpacingRadius,
      ],
    ),
    context: context,
  );
}

Future<void> openContactWebsite(String url) async {
  final launchTheUri = Uri.parse(url);
  if (await canLaunchUrl(launchTheUri)) {
    await launchUrl(launchTheUri);
  } else {
    if (kDebugMode) {
      print('The action is not supported. ( No phone app )');
    }
  }
}
