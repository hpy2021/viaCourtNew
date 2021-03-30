import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Widgets/custom_textFormField.dart';
import 'package:my_app/Constants/Applocalization.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(gradient: AppColors().gradient()),
                  width: double.infinity,
                  child: body()),
            ),
          ),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              SizedBox(
                height: 89,
              ),
              _signInText(),
              SizedBox(height: 31),
              Padding(
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
                                return 'Please enter email';
                              }
                              return null;
                            },
                            hintText: AppStrings.emailText,
                            obscureText: false,
                            controller: emailController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _bottomButtom()
                  ],
                ),
              ),
            ],
          ),
          _closeButton()
        ],
      ),
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

  _closeButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 56, 17, 0),
        height: 30,
        width: 30,
        decoration:
            BoxDecoration(color: Color(0xff51526E), shape: BoxShape.circle),
        child: Icon(
          Icons.clear,
          color: Colors.white,
          size: 18,
        ),
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
                          return 'Please enter email';
                        }
                        return null;
                      },
                      hintText: AppStrings.emailText,
                      obscureText: false,
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
          text: "Send",
          onPressed: () => {
            if (_formKey.currentState.validate())
              {Navigator.pop(context)}
            else
              {print('Error')}
          },
        ));
  }

  _signInText() {
    return Text(
      AppLocalizations.of(context).translate("Forgot Password"),
      style: AppTextStyles.bigTextStyle,
    );
  }
}
