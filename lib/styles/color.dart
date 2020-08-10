import 'package:flutter/material.dart' show Color;


class AppColors {
  static final appBlue1 = const Color(0xff3682DB);
  static final appBlue2 = const Color(0xff154C8D);

  static final appWhite = const Color(0xffffffff);
  static final appBlack = const Color(0xff000000);

  static final appGreen = const Color(0xff1BAC32);

  static final appGray1 = const Color(0xffF5F5F5);
  static final appGray2 = const Color(0xffD2D2D2);
  static final appGray3 = const Color(0xff606060);
  static final appGray4 = const Color(0xff353535);

  static final appRed = const Color(0xffE24545);

  //#ffc0cb  link pink intro screen
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

//Color primaryColorLight = const Color(0xFFFF8B4F);
//Color primaryColorDark = const Color(0xFFB72400);
//Color primaryColor = const Color(0xFF000000);
//Color accentColor = const Color(0xFF6A6A6D);
//Color grayColor = const Color(0xFFF1F1F1);

////87cfea  /// medium blue
////c9e9f6  /// lite blue c9e9f6   /// Color.fromARGB(999, 201, 233, 246),
////43b3e0  /// dark blue 43b3e0   /// Color.fromARGB(999, 67, 179, 224),