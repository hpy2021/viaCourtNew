import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Widgets/custom_textFormField.dart';

class ChangePassword extends StatefulWidget {
  UserResponse user;
  ChangePassword({@required this.user});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController, newPasscontroller,confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPasswordController = TextEditingController();
    newPasscontroller = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: _buildBody(context),
        ),
        AppConstants.progress(isLoading, context)
      ],
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
          Flexible(child: mainBody())
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
                      SizedBox(height: 20.0),
                      CustomTextFormField(

                        validator: (value) {
                          if(value.isEmpty){
                            return 'Please enter confrim password';

                          }
                          else if (newPasscontroller.text.trim() != value) {
                            return 'New password and confirm password does not match';
                          }
                          return null;
                        },hintText: AppStrings.confirmPasswordText,
                        obscureText:false ,
                        controller: confirmPasswordController,
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
                _updateApiCall()
              }
            else
              {print('Error')}
          },
        ));
  }

  _updateApiCall() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String,dynamic> request = new HashMap();
      request["firstname"] = widget.user.firstname;
      request["lastname"] = widget.user.lastname;
      request["email"]=widget.user.email;
      request["password"] = newPasscontroller.text;
      request["password_confirmation"] = confirmPasswordController.text;
      CommonResponse response = CommonResponse.fromJson(
          await ApiManager().postCallWithHeader(AppStrings.UPDATE_PROFILE + "/${widget.user.id}",request,context));

      if (response != null) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        print(response.message);
        Navigator.pop(context);
        setState(() {});
        // AppConstants().showToast(msg: "User returned SuccessFully");
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // AppConstants().showToast(msg: "${registerResponse.message}");
      }
    } else {
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

}
