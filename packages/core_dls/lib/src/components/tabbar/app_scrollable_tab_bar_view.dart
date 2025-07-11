// language: dart
import 'package:flutter/material.dart';

class AppScrollableTabBarView extends StatefulWidget {
  final List<String> sections;
  final List<Widget> sectionsWidgets;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? buttonMargin;
  final bool isHeaderScrollable;
  final double contentTopPadding;
  final Color activeButtonColor;
  final ScrollController? scrollController;
  final double initialScrollOffset;
  final Widget? stickyWidget;

  const AppScrollableTabBarView({
    super.key,
    required this.sections,
    required this.sectionsWidgets,
    this.buttonPadding,
    this.buttonMargin,
    this.isHeaderScrollable = true,
    this.contentTopPadding = 50.0,
    this.activeButtonColor = Colors.orange,
    this.scrollController,
    this.initialScrollOffset = 0.0,
    this.stickyWidget,
  });

  @override
  AppScrollableTabBarViewState createState() => AppScrollableTabBarViewState();
}

class AppScrollableTabBarViewState extends State<AppScrollableTabBarView> {
  late final ScrollController _scrollController;
  final ScrollController _buttonScrollController = ScrollController();
  List<double> sectionOffsets = [];
  int activeIndex = 0;
  bool offsetsCalculated = false;
  bool _isProgrammaticScroll = false;
  bool _externalController = false;

  late final List<GlobalKey> sectionKeys;
  late final List<GlobalKey> buttonKeys;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
      _externalController = true;
    } else {
      _scrollController = ScrollController();
    }
    _scrollController.addListener(_onScroll);

    sectionKeys = List.generate(widget.sections.length, (_) => GlobalKey());
    buttonKeys = List.generate(widget.sections.length, (_) => GlobalKey());

    // Calculate offsets and scroll to initial offset after widget renders.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
      if (widget.initialScrollOffset != 0.0) {
        _scrollController.jumpTo(widget.initialScrollOffset);
      }
    });
  }

  void _calculateSectionOffsets() {
    sectionOffsets = sectionKeys.map((key) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      return renderBox
          ?.localToGlobal(Offset.zero, ancestor: context.findRenderObject())
          .dy ??
          0.0;
    }).toList();
    offsetsCalculated = true;
    setState(() {});
  }

  void _onScroll() {
    if (_isProgrammaticScroll || !offsetsCalculated) return;
    double currentScroll = _scrollController.offset;
    for (int i = 0; i < sectionOffsets.length; i++) {
      if (currentScroll >= sectionOffsets[i] - widget.contentTopPadding &&
          (i == sectionOffsets.length - 1 ||
              currentScroll < sectionOffsets[i + 1] - widget.contentTopPadding)) {
        if (activeIndex != i) {
          setState(() {
            activeIndex = i;
          });
          _scrollToActiveButton();
        }
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    if (!offsetsCalculated || index >= sectionOffsets.length) return;
    setState(() {
      activeIndex = index;
      _isProgrammaticScroll = true;
    });
    _scrollToActiveButton();
    _scrollController
        .animateTo(sectionOffsets[index] - widget.contentTopPadding,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
        .then((_) {
      setState(() {
        _isProgrammaticScroll = false;
      });
    });
  }

  void _scrollToActiveButton() {
    if (buttonKeys[activeIndex].currentContext != null) {
      Scrollable.ensureVisible(
        buttonKeys[activeIndex].currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (!_externalController) {
      _scrollController.dispose();
    }
    _buttonScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerButtons;
    if (widget.isHeaderScrollable) {
      headerButtons = Column(
        children: [
          SizedBox(
            height: 50,
            child: SingleChildScrollView(
              controller: _buttonScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.sections.length, (index) {
                  bool isActive = index == activeIndex;
                  return InkWell(
                    onTap: () => _scrollToSection(index),
                    child: Container(
                      key: buttonKeys[index],
                      padding: widget.buttonPadding ?? const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive ? widget.activeButtonColor : Colors.grey,
                            width: isActive ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.sections[index],
                            style: isActive
                                ? TextStyle(
                              color: widget.activeButtonColor,
                              fontWeight: FontWeight.bold,
                            )
                                : const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4.0),

                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          widget.stickyWidget ?? const SizedBox.shrink(),
        ],
      );
    } else {
      headerButtons = Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: List.generate(widget.sections.length, (index) {
                bool isActive = index == activeIndex;
                return Expanded(
                  child: InkWell(
                    onTap: () => _scrollToSection(index),
                    child: Container(
                      key: buttonKeys[index],
                      padding: widget.buttonPadding ?? const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive ? widget.activeButtonColor : Colors.grey,
                            width: isActive ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.sections[index],
                            style: isActive
                                ? TextStyle(
                              color: widget.activeButtonColor,
                              fontWeight: FontWeight.bold,
                            )
                                : const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          widget.stickyWidget ?? const SizedBox.shrink(),
        ],
      );
    }

    return Column(
      children: [
        headerButtons,
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: List.generate(widget.sectionsWidgets.length, (index) {
                  return KeyedSubtree(
                    key: sectionKeys[index],
                    child: widget.sectionsWidgets[index],
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}