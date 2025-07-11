import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class AppTabBarView extends StatefulWidget {
  const AppTabBarView({
    super.key,
    required this.tablist,
    required this.tabColor,
    required this.onTap,
  });

  final List<AppTab> tablist;
  final Color tabColor;
  final Function(int)? onTap;
  @override
  State<AppTabBarView> createState() => _AppTabBarViewState();
}

class _AppTabBarViewState extends State<AppTabBarView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 5,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dragStartBehavior: DragStartBehavior.start,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _tabController,
      isScrollable: true,
      padding: const EdgeInsets.all(3),
      labelColor: AppColorTheme.pureBlack,
      labelStyle: context.appTextTheme.body,
      onTap: (value) {},
      unselectedLabelColor: AppColorTheme.darkBg,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        border: const Border(
            bottom: BorderSide(
          width: 3,
          color: AppColorTheme.orange80,
        )),
        color: widget.tabColor,
      ),
      unselectedLabelStyle: context.appTextTheme.body,
      tabs: widget.tablist,
    );
  }
}
