import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kPrimaryColor = const MaterialColor(
    0xff8358FF,
    const <int, Color>{
      50: const Color(0xffE6DFFF), //10%
      100: const Color(0xffCDBEFF), //20%
      200: const Color(0xffB4A0FF), //30%
      300: const Color(0xff9D88FF), //40%
      400: const Color(0xff7B61FF), //50%
      500: const Color(0xff5D46DC), //60%
      600: const Color(0xff4230B6), //70%
      700: const Color(0xff2C1F93), //80%
      800: const Color(0xff1D127A), //90%
      900: const Color(0xff000000), //100%
    },
  );

  static const MaterialColor kGreyColor = const MaterialColor(
    0xff979797,
    const <int, Color>{
      50: const Color(0xffFCFCFE), //10%
      100: const Color(0xffF6F6F6), //20%
      200: const Color(0xffEDEDED), //30%
      300: const Color(0xffCBCBCB), //40%
      400: const Color(0xff979797), //50%
      500: const Color(0xff525252), //60%
      600: const Color(0xff443B3C), //70%
      700: const Color(0xff241017), //80%
      800: const Color(0xff000000), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
