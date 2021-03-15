import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';

class AppTextStyles {
  static const TextStyle bigTextStyle =
      TextStyle(fontSize: 28, color: Colors.black);

  static const TextStyle hintTextStyle =
      TextStyle(fontSize: 17, color: AppColors.lightText_color);
  static const TextStyle smallTextStyle =
      TextStyle(fontSize: 13, color: Colors.black);
  static const TextStyle smallTextStyleWithColor =
      TextStyle(fontSize: 13, color: AppColors.lightGreenText_color);
  static const TextStyle green13 =
      TextStyle(fontSize: 13, color: AppColors.appColor_color);
  static const TextStyle smallTextStyleWithColor14 = TextStyle(
      fontSize: 14,
      color: AppColors.lightGreenText_color,
      fontWeight: FontWeight.w500);
  static const TextStyle regular14black =
      TextStyle(fontSize: 14, color: Colors.black);

  static const TextStyle loginButtonTextStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);
  static const TextStyle signUpTextStyle =
      TextStyle(fontSize: 16, color: AppColors.appColor_color);
  static const TextStyle textStyle18 =
      TextStyle(fontSize: 18, color: Color(0xff666666));
  static const TextStyle textStyle18black =
      TextStyle(fontSize: 18, color: Color(0xff000000));
  static const TextStyle textStyle18white =
      TextStyle(fontSize: 18, color: Colors.white);
  static const TextStyle textStyle16 =
      TextStyle(fontSize: 16, color: AppColors.lightText_color);
  static const TextStyle textStyle14medium = TextStyle(
      fontSize: 14,
      color: AppColors.itemListTextcolor,
      fontWeight: FontWeight.w500);
  static const TextStyle textStyle14mediumblack =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500);
  static const TextStyle textStyle25white =
      TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.w400);
  static const TextStyle textStyle14grey = TextStyle(
    fontSize: 14,
    color: Color(0xff666666),
  );
  static const TextStyle textStyle15medium = TextStyle(
      fontSize: 15, color: Color(0xff666666), fontWeight: FontWeight.w500);
  static const TextStyle textStyle15mediumblack =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
  static const TextStyle textStyle18mediumwithGreen = TextStyle(
      fontSize: 18,
      color: AppColors.appColor_color,
      fontWeight: FontWeight.w500);
  static const TextStyle textStyle18medium =
      TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500);

  static const TextStyle textStyle14green =
      TextStyle(fontSize: 14, color: AppColors.appColor_color);
  static const TextStyle textStyle12regular =
      TextStyle(fontSize: 12, color: Colors.white);
  static const TextStyle textStyle14greenmedium = TextStyle(
      fontSize: 14,
      color: AppColors.appColor_color,
      fontWeight: FontWeight.w500);

  static const TextStyle textStyle12medium = TextStyle(
      color: Color(0xff666666), fontWeight: FontWeight.w500, fontSize: 12);
  static const TextStyle textStyle12mediumlight = TextStyle(
      color: Color(0xffE2E2E2), fontWeight: FontWeight.w500, fontSize: 12);
}
