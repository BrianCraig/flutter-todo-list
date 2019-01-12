import 'package:flutter/material.dart';

const double _sizeUnit = 4;

class DefaultStyle {
  static border() => const BorderRadius.all(Radius.circular(_sizeUnit));

  static padding() => const EdgeInsets.all(_sizeUnit * 2);

  static sizeUnit() => _sizeUnit;
}
