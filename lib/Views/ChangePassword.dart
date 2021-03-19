import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Widgets/custom_textFormField.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController, newPasscontroller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPasswordController = TextEditingController();
    newPasscontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors().homegradient()),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          AppConstants()
              .header(text: AppStrings.changePasswordText, context: context),
          SizedBox(
            height: 13,
          ),
          Flexible(child: mainBody2())
        ],
      ),
    );
  }

  mainBody() {
    return BackgroundCurvedView(
      widget: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: currentPasswordController,
                hintText: AppStrings.currentPassText,
                obscureText: false,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                controller: newPasscontroller,
                hintText: AppStrings.newPassText,
                obscureText: false,
              ),
              Expanded(child: SizedBox()),
              _bottomButtom()
            ],
          ),
        ),
      ),
    );
  }

  mainBody2() {
    return BackgroundCurvedView(
      widget: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter current password';
                          }
                          return null;
                        },hintText: AppStrings.currentPassText,
                        obscureText:false ,
                        controller: currentPasswordController,
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormField(

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },hintText: AppStrings.newPassText,
                        obscureText:false ,
                        controller: newPasscontroller,
                      ),
                    ],
                  ),),
              Expanded(child: SizedBox()),
              _bottomButtom()
            ],
          ),
        ),
      ),
    );
  }

  _bottomButtom() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: CustomButton(
          text: "Update",
          onPressed: () => {
            if (_formKey.currentState.validate())
              {
                Navigator.pop(context)
              }
            else
              {print('Error')}
          },
        ));
  }
}
