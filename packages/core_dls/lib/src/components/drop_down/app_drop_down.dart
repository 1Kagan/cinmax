import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/drop_down/drop_down_model.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class AppDropDownButton<T extends DropDownModelMixin> extends StatefulWidget {
  const AppDropDownButton({
    super.key,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.labelTextStyle,
    this.selectedValue,
    this.labelTextScaler,
    this.horizontalPadding = 16,
    this.isSearchable = false,
    this.disabledItems = const [],
  });

  final List<T> items;
  final String hintText;
  final Function(T)? onChanged;
  final T? selectedValue;
  final double horizontalPadding;
  final bool isSearchable;
  final TextStyle? labelTextStyle;
  final TextScaler? labelTextScaler;
  final List<bool> disabledItems;

  @override
  State<AppDropDownButton<T>> createState() => _AppDropDownButtonState<T>();
}

class _AppDropDownButtonState<T extends DropDownModelMixin>
    extends State<AppDropDownButton<T>> {
  T? selectedValue;
  TextEditingController searchController = TextEditingController();
  List<T> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    filteredItems = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      buttonStyleData: ButtonStyleData(
        width: double.infinity,
        height: 44.h,
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18).r,
          border: Border.all(
            width: 1,
            color: selectedValue == null
                ? AppColorTheme.transparent
                : AppColorTheme.transparent,
          ),
        ),
      ),
      underline: const SizedBox.shrink(),
      isExpanded: true,
      iconStyleData: IconStyleData(
        icon: DLSAssets.icons.arrowDown1.svg(
          height: 24.h,
          width: 24.w,
          colorFilter: ColorFilter.mode(
            Theme.of(context).textTheme.bodyLarge?.color ??
                AppColorTheme.gray500,
            BlendMode.srcIn,
          ),
        ),
      ),
      hint: Text(
        widget.hintText,
        style: context.appTextTheme.body?.copyWith(
            color: Theme.of(context).textTheme.bodySmall!.color,
            fontSize: 14.sp),
      ),
      items: filteredItems
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              enabled: e.isEnabled,
              child: Text(
                e.label,
                style: e.textStyle ?? (widget.labelTextStyle ?? context.appTextTheme.body?.copyWith(
                  color: AppColorTheme.gray500,
                  fontSize: 14.sp,
                )),
                textAlign: TextAlign.start,
                textScaler: widget.labelTextScaler,
              ),
            ),
          )
          .toList(),
      value: selectedValue,
      menuItemStyleData: MenuItemStyleData(
        padding: const EdgeInsets.only(left: 16),
        selectedMenuItemBuilder: (BuildContext context, Widget child) {
          return Container(
            color: AppColorTheme.gray50,
            child: child,
          );
        },
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(
            color: AppColorTheme.gray50,
            width: 1.r,
          ),
        ),
      ),
      dropdownSearchData: widget.isSearchable
          ? DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Padding(
                padding: const EdgeInsets.all(8).r,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value?.label
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()) ??
                    false;
              },
            )
          : null,
      onChanged: (item) {
        setState(() => selectedValue = item);
        final value =
            widget.items.firstWhereOrNull((e) => e.value == item?.value);
        if (value != null) {
          widget.onChanged?.call(value);
        }
      },
      onMenuStateChange: widget.isSearchable
          ? (isOpen) {
              if (!isOpen) {
                searchController.clear();
              }
            }
          : null,
    );
  }
}
