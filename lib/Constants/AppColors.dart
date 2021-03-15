import 'package:flutter/material.dart';

class AppColors {
  static const Color gradient_color1 = Colors.white;
  static const Color gradient_color2 = Color(0xffD5F1F2);
  static const Color border_color = Color(0xff3FA786);
  static const Color lightGreenText_color = Color(0xff3FA786);
  static const Color appColor_color = Color(0xff008840);
  static const Color lightText_color = Color(0xffC3CCDB);
  static const Color purpleText_color = Color(0xff7483A0);
  static const Color home_gradient1 = Color(0xff01AB6A);
  static const Color home_gradient2 = Color(0xff009D88);
  static const Color itemListBackGroundColor = Color(0xffD5F1F2);
  static const Color itemListTextcolor = Color(0xff438282);
  static const Color bottomNavigationBarTextColor = Color(0xff333333);
  static const Color availableBackgroundColor = Color(0xffEBEBEB);
  static const Color availableTextColor = Color(0xffA8A8A8);
  static const Color notavailableBackgroundColor = Color(0xffFFD4D4);
  static const Color notavailableTextColor = Color(0xffDB4646);
  static const Color notselectedColor = Color(0xffDCDCDC);
  static const Color selectedColor = Color(0xff28463C);
  static const Color selectedItemColor = Color(0xff07C25F);
  static const Color notselectedItemColor = Color(0xffA7A7A7);
  static const Color yellowColor = Color(0xffFFD500);
  static const Color pinkColor = Color(0xffFF6868);


  Map<int, Color> color = {
    50: Color.fromRGBO(0, 136, 64, .1),
    100: Color.fromRGBO(0, 136, 64, .2),
    200: Color.fromRGBO(0, 136, 64, .3),
    300: Color.fromRGBO(0, 136, 64, .4),
    400: Color.fromRGBO(0, 136, 64, .5),
    500: Color.fromRGBO(0, 136, 64, .6),
    600: Color.fromRGBO(0, 136, 64, .7),
    700: Color.fromRGBO(0, 136, 64, .8),
    800: Color.fromRGBO(0, 136, 64, .9),
    900: Color.fromRGBO(0, 136, 64, 1),
  };

  gradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.center,
        colors: [gradient_color1, gradient_color2]);
  }

  homegradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [home_gradient1, home_gradient2]);
  }
}
