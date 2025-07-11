import 'package:flutter/material.dart';

class AppConfigurableTabView extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final TabController? controller;
  final double? tabContentSpacing;
  final Color? indicatorColor;
  final Color? dividerColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final bool isScrollable;
  final BoxDecoration? tabDecoration;
  final BoxDecoration? selectedTabDecoration;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Decoration? indicator;
  final EdgeInsets? labelPadding;
  final TabBarIndicatorSize? indicatorSize;
  final TextScaler? textScaler;
  final ValueChanged<int>?
      onTabChanged; // Sekme değişikliklerini takip etmek için

  const AppConfigurableTabView({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    this.tabContentSpacing,
    this.controller,
    this.indicatorColor,
    this.dividerColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.isScrollable = false,
    this.tabDecoration,
    this.selectedTabDecoration,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicator,
    this.labelPadding,
    this.indicatorSize,
    this.textScaler,
    this.onTabChanged, // onTabChanged işlevi
  }) : assert(tabTitles.length == tabContents.length,
            'Tab ve içerik sayısı eşit olmalıdır.');

  @override
  _AppConfigurableTabViewState createState() => _AppConfigurableTabViewState();
}

class _AppConfigurableTabViewState extends State<AppConfigurableTabView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = widget.controller ??
        TabController(length: widget.tabTitles.length, vsync: this);

    if (widget.onTabChanged != null) {
      _tabController?.addListener(() {
        if (_tabController?.indexIsChanging == false) {
          widget.onTabChanged?.call(_tabController!.index);
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabAlignment:
              widget.isScrollable ? TabAlignment.start : TabAlignment.fill,
          controller: _tabController,
          isScrollable: widget.isScrollable,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFFFE5000)),
          ),
          indicatorSize: widget.indicatorSize ?? TabBarIndicatorSize.label,
          labelColor: widget.labelColor ?? const Color(0xFFFE5000),
          labelStyle: widget.labelStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
          unselectedLabelStyle: widget.unselectedLabelStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
          unselectedLabelColor: widget.unselectedLabelColor ?? Colors.grey,
          tabs: List.generate(widget.tabTitles.length, (index) {
            final isSelected = _tabController?.index == index;
            if (isSelected) {
              return Tab(
                child: Text(
                  widget.tabTitles[index],
                  textScaler: widget.textScaler ?? TextScaler.noScaling,
                ),
              );
            } else {
              return Tab(
                child: Text(
                  widget.tabTitles[index],
                  textScaler: widget.textScaler ?? TextScaler.noScaling,
                ),
              );
            }
          }),
          labelPadding: widget.labelPadding ?? EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        SizedBox(height: widget.tabContentSpacing ?? 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabContents,
          ),
        ),
      ],
    );
  }
}
