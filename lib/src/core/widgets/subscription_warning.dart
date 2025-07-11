import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

void showSubscriptionWarningBottomSheet(
  BuildContext context, {
  String? message,
}) {
  context.showContentBottomSheet(
    title: context.l10n.translate('warning_bottomsheet'),
    buttonLabel: context.l10n.translate('marketplace_call_button_title'),
    useSecondButton: true,
    secondButtonLabel: context.l10n.translate('send_email_button'),
    onCloseButtonTap: (context) => Navigator.of(context).pop(),
    onButtonTap: (_) {
      phoneHelpButton();
    },
    secondButtonOnTap: mailHelpButton,
    content: Column(
      children: [
        12.verticalSpacingRadius,
        Text(
          message ?? context.l10n.translate('forecasters_subscription_warning'),
          style: context.appTextTheme.body,
        ),
        12.verticalSpacingRadius,
      ],
    ),
    context: context,
  );
}

Future<void> mailHelpButton() async {
  const subject = '';
  const body = '';

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  final emailUri = Uri(
    scheme: 'mailto',
    path: 'support@example.com',
    query: encodeQueryParameters(
      <String, String>{'subject': subject, 'body': body},
    ),
  );
  if (await launchUrl(emailUri)) {
    await canLaunchUrl(emailUri);
  } else {
    throw Exception('Could not launch $emailUri');
  }
}

Future<void> phoneHelpButton() async {
  final launchTheUri = Uri(
    scheme: 'tel',
    path: '+90 123 456 78 90',
  );
  if (await canLaunchUrl(launchTheUri)) {
    await launchUrl(launchTheUri);
  } else {
    throw Exception('The action is not supported. ( No phone app )');
  }
}
