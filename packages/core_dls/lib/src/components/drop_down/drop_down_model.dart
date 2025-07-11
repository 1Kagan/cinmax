import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:core_dls/src/domain/displayable.dart';

mixin DropDownModelMixin<T> on Displayable {
  T get value;
}

class DropDownModel<T> extends Equatable implements DropDownModelMixin<T> {
  const DropDownModel(
    this._name, {
    required T value,
    this.isEnabled = true,
        this.textStyle
  }) : _value = value;

  final String _name;
  final T _value;


  @override
  final TextStyle? textStyle;

  @override
  final bool isEnabled;

  @override
  String get label => _name;

  @override
  T get value => _value;

  @override
  List<Object?> get props => [value];

}
