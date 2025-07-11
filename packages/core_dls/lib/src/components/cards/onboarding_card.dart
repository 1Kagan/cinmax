import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/indicator/dot_indicator.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/constants/constants.dart';

import '../../extensions/app_animation_extension.dart';
import '../../theme/app_color_theme.dart';
import '../../theme/app_text_theme.dart';

class OnboardingCard extends StatefulWidget {
  const OnboardingCard({
    super.key,
    required this.items,
    this.currentIndexOnTap,
  });

  final List<OnboardCardItem> items;
  // when user tap on the card, this function will be called with the current index
  final Function(int)? currentIndexOnTap;

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard> {
  late final PageController _pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _activeIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.r,
        vertical: 16.h,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: GestureDetector(
          onTap: () => widget.currentIndexOnTap?.call(_activeIndex),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ..._background,
              _body,
              PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) => setState(() => _activeIndex = i),
                children: List.generate(
                  widget.items.length,
                  (index) => const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _indicatorAndButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _background => [
        ...List.generate(
          widget.items.length,
          (index) => Image.asset(
            widget.items[index].imagePath,
            fit: BoxFit.cover,
          ).effectOpacity(
            opacity: _activeIndex == index ? 1 : 0,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF121225).withOpacity(0.8),
                const Color(0xFF121225).withOpacity(0),
                const Color(0xFF121225).withOpacity(0),
                const Color(0xFF121225).withOpacity(0.7),
              ],
            ),
          ),
        ),
      ];

  Widget get _body => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 32.r,
            horizontal: 24.r,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBody,
              const Spacer(),
            ],
          ),
        ),
      );

  Widget get _textBody => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.items[_activeIndex].title,
            style: context.appTextTheme.hero?.copyWith(
              color: AppColorTheme.pureWhite,
            ),
          ).effectFadeSlideDown(delay: 0.3),
          SizedBox(height: 8.r),
          Builder(
            builder: (context) {
              return Text(
                widget.items[_activeIndex].content ?? '',
                style: context.appTextTheme.body?.copyWith(
                  color: AppColorTheme.pureWhite,
                ),
              ).effectFadeSlideDown();
            },
          ),
        ],
      );

  Widget get _indicatorAndButton => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 32.r,
          horizontal: 24.r,
        ),
        child: Row(
          children: [
            DotIndicator(
              activeIndex: _activeIndex,
              activeColor: AppColorTheme.pureWhite,
              pageLength: widget.items.length,
              radius: 8.r,
              borderWidth: 1.r,
              indicatorSpace: 6.r,
            ),
            const Spacer(),
            _button,
          ],
        ),
      );

  Widget get _button => Row(
        children: [
          Text(
            widget.items[_activeIndex].buttonName ?? '',
            style: context.appTextTheme.button?.copyWith(
              color: AppColorTheme.pureWhite,
            ),
          ),
          SizedBox(width: 8.w),
          DLSAssets.icons.arrowCircleRight.svg(
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              AppColorTheme.pureWhite,
              BlendMode.srcIn,
            ),
            package: Constants.dlsPackageName,
          ),
        ],
      );
}

class OnboardCardItem {
  OnboardCardItem({
    required this.imagePath,
    required this.title,
    this.content,
    this.buttonName,
  });

  final String imagePath;
  final String title;
  final String? content;
  final String? buttonName;
}
