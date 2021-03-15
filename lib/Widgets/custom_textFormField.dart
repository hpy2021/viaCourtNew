import 'package:flutter/material.dart';
import '../Constants/AppTextStyles.dart';
import '../Constants/AppColors.dart';

class CustomTextFormField extends StatelessWidget {

  CustomTextFormField({
    @required this.controller,
    @required this.obscureText,
    this.hintStyle,
    this.hintText,
    this.validator,
    this.onTap
});
 TextEditingController controller;
 String hintText;
  TextStyle hintStyle;
  bool obscureText = false;
  Function validator,onTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        validator: validator,
onTap: onTap,


controller: controller,
  obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: AppTextStyles.hintTextStyle,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.border_color)),
focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.border_color)),
        ),
      ),
    );
  }
}
