import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Bottom Sheet',
      body: ListView(
        children: [
          LinkListTile(
            title: 'Informative Bottom Sheet',
            onTap: () {
              context.showInformativeBottomSheet(
                title: 'Message successfully sent',
                subTitle: Text(
                  'Thank you for your feedback.\nWe will get back to you very soon.',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: AppColorTheme.text,
                  ),
                ),
                buttonLabel: 'Continue',
                onButtonTap: () {},
              );
            },
          ),
          LinkListTile(
            title: 'Positive Bottom Sheet',
            onTap: () {
              context.showPositiveBottomSheet(
                title: 'Message successfully sent',
                subTitle: Text(
                  'Thank you for your feedback.\nWe will get back to you very soon.',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: AppColorTheme.text,
                  ),
                ),
                buttonLabel: 'Continue',
                onButtonTap: () {},
              );
            },
          ),
          LinkListTile(
            title: 'Negative Bottom Sheet',
            onTap: () {
              context.showNegativeBottomSheet(
                title: 'An error occurred ',
                subTitle: Text(
                  'Please try again to send message. We will not delete your feedback unless you close the app. ',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: AppColorTheme.text,
                  ),
                ),
                buttonLabel: 'Continue',
                onButtonTap: () {},
              );
            },
          ),
          LinkListTile(
            title: 'Custom Bottom Sheet',
            onTap: () {
              context.showCustomBottomSheet(
                  title: 'Transaction has been sent',
                  subTitle: Text(
                    'Transaction has been sent to the blockchain',
                    style: context.appTextTheme.bodySmall?.copyWith(
                      color: AppColorTheme.text,
                    ),
                  ),
                  buttonLabel: 'Continue',
                  onButtonTap: () {},
                  headerIcon: DLSAssets.icons.send2.svg(
                      colorFilter: const ColorFilter.mode(
                          AppColorTheme.positive, BlendMode.srcIn)));
            },
          )
        ],
      ),
    );
  }
}
