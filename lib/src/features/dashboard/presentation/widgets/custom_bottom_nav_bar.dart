import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildNavItem(
              context,
              'assets/svgs/home.svg',
              context.l10n.translate('home'),
              0,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildNavItem(
              context,
              'assets/svgs/profile.svg',
              context.l10n.translate('profile'),
              1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, String iconPath, String label, int index) {
    final theme = Theme.of(context);
    final isSelected = selectedIndex == index;
    final color = isSelected
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withOpacity(0.5);

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.2),
          borderRadius: BorderRadius.circular(32.r),
          border: isSelected
              ? Border.all(color: theme.colorScheme.onSurface.withOpacity(0.4))
              : Border.all(color: theme.colorScheme.onSurface.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
