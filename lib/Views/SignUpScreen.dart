import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/SignUpResposne.dart';
import 'package:my_app/Models/SignUpResposne.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/BottomNavigationBarHome.dart';
import 'package:my_app/Views/SelectCourtSizeScreen.dart';
import 'package:my_app/Views/LoginScreen.dart';
import 'package:my_app/Views/HomeScreen.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Widgets/custom_textFormField.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool isSwitchedOn = false;
  bool isLoading = false;
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();

  signInApiCall(
      {String firstName,
      String lastName,
      String email,
      String password,
      // String mobileNo,
      String confirmpassword}) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });

      var request = Map<String, dynamic>();
      request["firstname"] = firstName;
      request["lastname"] = lastName;
      request["email"] = email;
      // request["mobile"] = mobileNo;
      request["password"] = password;
      request["password_confirmation"] = confirmpassword;
      SignUpResponse registerResponse = SignUpResponse.fromJson(
        await ApiManager()
            .postCall(AppStrings.REGISTRATION_URL, request, context),
      );

      if (registerResponse.status == 201) {
        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            AppStrings.TOKEN_KEY, registerResponse.csrf);
        await sharedPreferences.setBool("isRemindme", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarView()));
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // print(email + " " + password + " " + userName + " " + mobileNo);
        AppConstants().showToast(msg: "User Created SuccessFully");
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // if(registerResponse.errors.email == null ){
        //   // AppConstants().showToast(msg: "${registerResponse.errors.email[0]}");
        //
        // }
        AppConstants().showToast(msg: "${registerResponse.errors.email[0]}");
      }
    } else {
      if (mounted)
        setState(
          () {
            isLoading = false;
          },
        );
      AppConstants().showToast(msg: "No internet connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _body(),
          ),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: AppColors().gradient()),
            width: double.infinity,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 89,
                  ),
                  _signInText(),
                  SizedBox(height: 31),
                  CustomTextFormField(
                    controller: firstNameController,
                    hintText: AppStrings.firstNameText,
                    obscureText: false,
                  ),
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: lastNameController,
                    hintText: AppStrings.lastNameText,
                    obscureText: false,
                  ),
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: AppStrings.emailText,
                    obscureText: false,
                  ),
                  // SizedBox(height: 25),
                  // CustomTextFormField(
                  //   controller: phoneController,
                  //   hintText: AppStrings.phoneText,
                  //   obscureText: true,
                  // ),
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: AppStrings.createPasswordText,
                    obscureText: true,
                  ),
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: AppStrings.confirmPasswordText,
                    obscureText: true,
                  ),
                  SizedBox(height: 25),
                  _loginButton(),
                  SizedBox(
                    height: 18,
                  ),
                  _bottomLineText()
                ],
              ),
            ),
          ),
          _closeButton()
        ],
      ),
    );
  }

  _bottomLineText() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          text: AppStrings.haveaccountUpText,
          style: TextStyle(fontSize: 16, color: AppColors.purpleText_color),
          children: [
            TextSpan(
                text: AppStrings.signInText,
                style: AppTextStyles.signUpTextStyle)
          ],
        ),
      ),
    );
  }

  _signInText() {
    return Text(
      "Sign Up",
      style: AppTextStyles.bigTextStyle,
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

  _loginButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: CustomButton(
          text: "Sign Up",
          onPressed: () => {_validationCheck()},
        ));
  }

  _validationCheck() {
    if (firstNameController.text.trim().isEmpty) {
      AppConstants().showToast(msg: "Please enter First name");
    } else if (lastNameController.text.trim().isEmpty) {
      AppConstants().showToast(msg: "Please enter Last name");
    } else if (emailController.text.trim().isEmpty) {
      AppConstants().showToast(msg: "Please enter email");
    } else if (passwordController.text.trim().isEmpty) {
      AppConstants().showToast(msg: "Please enter mobile number");
    } else if (confirmPasswordController.text.trim().isEmpty) {
      AppConstants().showToast(msg: "Please enter password");
    } else if (confirmPasswordController.text != passwordController.text) {
      AppConstants()
          .showToast(msg: "Password and confirm password does not match");
    } else {
      signInApiCall(
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          password: passwordController.text,
          confirmpassword: confirmPasswordController.text);
    }
  }
}
