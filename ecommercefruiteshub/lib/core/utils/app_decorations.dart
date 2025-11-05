import 'package:flutter/material.dart';

abstract class AppDecorations {
  static var greyBoxDecorationUnSelected = ShapeDecoration(
    color: const Color(0x7FF2F3F3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(color: Colors.grey),
    ),
  );
  static var greyBoxDecorationSelected = ShapeDecoration(
    color: const Color(0x7FF2F3F3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(color: Color(0xff1F5E3B)),
    ),
  );
}
