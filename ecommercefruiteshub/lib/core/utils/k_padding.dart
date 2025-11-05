import 'package:flutter/material.dart';

class KPadding {
  // Common symmetric paddings
  static const all8 = EdgeInsets.all(8);
  static const all16 = EdgeInsets.all(16);
  static const all24 = EdgeInsets.all(24);

  // Horizontal & vertical only
  static const horizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const vertical8 = EdgeInsets.symmetric(vertical: 8);
  static const vertical16 = EdgeInsets.symmetric(vertical: 16);

  // Custom paddings
  static const top16 = EdgeInsets.only(top: 16);
  static const bottom8 = EdgeInsets.only(bottom: 8);
  static const bottom16 = EdgeInsets.only(bottom: 16);
  static const left12 = EdgeInsets.only(left: 12);
  static const right12 = EdgeInsets.only(right: 12);
}
