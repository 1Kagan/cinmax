import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialLoginButton(context, 'assets/svgs/google.svg', isLight),
        SizedBox(width: 8.w),
        _buildSocialLoginButton(context, 'assets/svgs/apple.svg', isLight),
        SizedBox(width: 8.w),
        _buildSocialLoginButton(context, 'assets/svgs/facebook.svg', isLight),
      ],
    );
  }

  Widget _buildSocialLoginButton(
      BuildContext context, String imagePath, bool isLight) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // TODO: Handle social login
      },
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isLight
              ? colorScheme.surface.withOpacity(0.1)
              : const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isLight
                ? colorScheme.onSurface.withOpacity(0.2)
                : const Color(0x33FFFFFF),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            imagePath,
            width: 20.w,
            height: 20.h,
            colorFilter: ColorFilter.mode(
              isLight ? colorScheme.onSurface : const Color(0xFFFFFFFF),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
