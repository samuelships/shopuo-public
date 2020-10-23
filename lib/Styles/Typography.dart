import 'package:flutter/material.dart';
import 'package:shopuo/Styles/Color.dart';

class MyTypography {
  // BASE
  static final base = TextStyle(
    fontFamily: "SF Pro Display",
  );

  // SEMI BOLD
  static final heading1SB = base.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final heading2SB = base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final heading4SB = base.copyWith(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static final heading6SB = base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final heading5SB = base.copyWith(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  // REGULAR
  static final heading1R = base.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final heading6R = base.copyWith(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static final heading4R = base.copyWith(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  // LIGHT
  static final heading5L = base.copyWith(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );

  // OTHER
  static final body1 = base.copyWith(
    fontSize: 15,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w400,
  );

  static final body2 = base.copyWith(
    fontSize: 13,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w400,
  );

  static final bodyParagraph = base.copyWith(
    fontSize: 16,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w400,
  );

  static final smallText = base.copyWith(
    fontSize: 11,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w300,
  );

  static final button2 = base.copyWith(
    fontSize: 12,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w400,
  );

  static final bodyInput = base.copyWith(
    fontSize: 13,
    color: MyColor.neutralBlack,
    fontWeight: FontWeight.w400,
  );

  static final bigHeader = base.copyWith(
    fontSize: 48,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}
