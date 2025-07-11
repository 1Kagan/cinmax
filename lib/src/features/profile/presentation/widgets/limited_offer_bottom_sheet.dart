import 'dart:ui';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      child: Container(
        color: isLight ? AppColorTheme.white : const Color(0xFF090909),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -100,
              child: Container(
                width: 217,
                height: 217,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFE50914),
                      blurRadius: 216,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  _buildBonusSection(context),
                  _buildPackagesSection(context),
                  _buildAllTokensButton(context),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Text(
            context.l10n.translate('limited_offer'),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.translate('limited_offer_subtitle'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBonusSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 366.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isLight ? AppColorTheme.gray50 : Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isLight ? AppColorTheme.gray100 : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Text(
              context.l10n.translate('your_bonuses'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BonusItem(
                    iconPath: 'assets/images/premium.png',
                    label: context.l10n.translate('premium_account')),
                _BonusItem(
                    iconPath: 'assets/images/love.png',
                    label: context.l10n.translate('more_matches')),
                _BonusItem(
                    iconPath: 'assets/images/first.png',
                    label: context.l10n.translate('showcase')),
                _BonusItem(
                    iconPath: 'assets/images/sololove.png',
                    label: context.l10n.translate('more_likes')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackagesSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Text(
            context.l10n.translate('select_package_to_unlock'),
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface),
          ),
          SizedBox(height: 24.h),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _JetonPackageCard(
                  badgeText: '+10%',
                  oldValue: '200',
                  newValue: '330',
                  price: '₺99,99',
                  gradientColors: [Color(0xFF6F060B), Color(0xFFE50914)],
                  badgeColor: Color(0xFF6F060B),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _JetonPackageCard(
                  badgeText: '+70%',
                  oldValue: '2.000',
                  newValue: '3.375',
                  price: '₺799,99',
                  gradientColors: [Color(0xFF5949E6), Color(0xFFE50914)],
                  badgeColor: Color(0xFF5949E6),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _JetonPackageCard(
                  badgeText: '+35%',
                  oldValue: '1.000',
                  newValue: '1.350',
                  price: '₺399,99',
                  gradientColors: [Color(0xFF6F060B), Color(0xFFE50914)],
                  badgeColor: Color(0xFF6F060B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllTokensButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PrimaryButton(
        text: context.l10n.translate('view_all_tokens'),
        onTap: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE50914),
          minimumSize: Size(367.w, 53.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class _BonusItem extends StatelessWidget {
  final String iconPath;
  final String label;
  const _BonusItem({required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(
          width: 55,
          height: 55,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(55, 55),
                painter: _InnerGlowPainter(),
              ),
              Image.asset(iconPath, width: 30, height: 30),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _InnerGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()..color = const Color(0xFF6F060B);
    canvas.drawCircle(center, radius, backgroundPaint);

    final gradientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.4),
        ],
        stops: const [0.0, 0.8, 1.0],
      ).createShader(rect);

    canvas.drawCircle(center, radius, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _JetonPackageCard extends StatelessWidget {
  final String badgeText;
  final String oldValue;
  final String newValue;
  final String price;
  final List<Color> gradientColors;
  final Color badgeColor;

  const _JetonPackageCard({
    required this.badgeText,
    required this.oldValue,
    required this.newValue,
    required this.price,
    required this.gradientColors,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    const cardHeight = 230.0;

    return Container(
      width: 111.71.w,
      height: cardHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(16),
        gradient: RadialGradient(
          colors: gradientColors,
          center: const Alignment(0, -0.5),
          radius: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _PackageCardInnerGlowPainter(),
            ),
          ),
          Positioned(
            top: -12.5,
            child: SizedBox(
              width: 61,
              height: 25,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(61, 25),
                    painter: _BadgeInnerGlowPainter(badgeColor: badgeColor),
                  ),
                  Text(
                    badgeText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                oldValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                newValue,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                context.l10n.translate('jeton'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Divider(color: Colors.white24, indent: 10, endIndent: 10),
              Text(
                price,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                context.l10n.translate('weekly_per_unit'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ],
      ),
    );
  }
}

class _PackageCardInnerGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );

    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -1.4),
        radius: 1,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6],
      ).createShader(rrect.outerRect);

    canvas.drawRRect(rrect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BadgeInnerGlowPainter extends CustomPainter {
  final Color badgeColor;

  _BadgeInnerGlowPainter({required this.badgeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );

    final backgroundPaint = Paint()..color = badgeColor;
    canvas.drawRRect(rrect, backgroundPaint);

    final outerPath = Path()..addRRect(rrect);
    final innerPath = Path()..addRRect(rrect.deflate(2.0));

    final ringPath =
        Path.combine(PathOperation.difference, outerPath, innerPath);

    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.clipPath(outerPath);
    canvas.drawPath(ringPath, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _BadgeInnerGlowPainter &&
        oldDelegate.badgeColor != badgeColor;
  }
}
