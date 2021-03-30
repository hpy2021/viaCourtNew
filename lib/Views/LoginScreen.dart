import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Models/MobileDetailResponse.dart';
import 'package:my_app/Views/ForgotPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/LoginResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/BottomNavigationBarHome.dart';
import 'package:my_app/Constants/Applocalization.dart';
import 'package:my_app/Views/SelectCourtSizeScreen.dart';
import 'package:my_app/Views/OtpScreen.dart';
import 'package:my_app/Views/SignUpScreen.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Widgets/custom_textFormField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isSwitchedOn = false;
  bool isLoading = false;
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  String fcmToken;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  loginApiCall({
    String email,
    String password,
  }) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });

      var request = Map<String, dynamic>();

      request["email"] = email;
      request["password"] = password;
      // request["device_token"] = fcmToken;
      LoginResponse loginresponse = LoginResponse.fromJson(
          await ApiManager().postCall(AppStrings.LOGIN_URL, request, context));

      if (loginresponse.status == 200) {
        print("token : ${loginresponse.token}");

        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            AppStrings.TOKEN_KEY, loginresponse.token);
        await sharedPreferences.setBool("isRemindme", isSwitchedOn);
        mobileDetail(userId: loginresponse.user.id);
        print(loginresponse.user.id);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarView(
              selectedIndex: 0,
            ),
          ),
        );
        if (mounted)
          setState(() {
            isLoading = false;
          });
        AppConstants().showToast(msg: "Successfully Logged In");
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        AppConstants().showToast(msg: loginresponse.errors.email[0]);
        // emailController.clear();
        // passwordController.clear();

      }
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      AppConstants().showToast(msg: "Internet is not available");
    }
  }
  // http://127.0.0.1:8000/api/user/mobileDetails
  mobileDetail({
int userId
  }) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });

      var request = Map<String, dynamic>();

      request["device_token"] = fcmToken;
      request["device_manufacture"] = _deviceData["manufacturer"];
request["device_model"] = _deviceData["model"];
request["plateform"] = Platform.isAndroid ? "an" : "ios";
request["users_id"] = "$userId";
      MobileDetailResponse loginresponse = MobileDetailResponse.fromJson(
          await ApiManager().postCall("http://167b770e8969.ngrok.io/api/user/mobileDetails", request, context));
print(loginresponse.mobileConfiguration);
      // if (loginresponse.status == 200) {
      //   print("token : ${loginresponse.token}");
      //
      //   sharedPreferences = await SharedPreferences.getInstance();
      //   await sharedPreferences.setString(
      //       AppStrings.TOKEN_KEY, loginresponse.token);
      //   await sharedPreferences.setBool("isRemindme", isSwitchedOn);
      //
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => BottomNavigationBarView(
      //         selectedIndex: 0,
      //       ),
      //     ),
      //   );
      //   if (mounted)
      //     setState(() {
      //       isLoading = false;
      //     });
      //   AppConstants().showToast(msg: "Successfully Logged In");
      // } else {
      //   if (mounted)
      //     setState(() {
      //       isLoading = false;
      //     });
    //     AppConstants().showToast(msg: loginresponse.errors.email[0]);
    //     // emailController.clear();
    //     // passwordController.clear();
    //
    //   }
    // } else {
    //   if (mounted)
    //     setState(() {
    //       isLoading = false;
    //     });
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        print(deviceData["brand"] +
            deviceData["device"] +
            deviceData["manufacturer"] +
            deviceData["product"] +
            deviceData["model"]);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'brand': build.brand,
      'device': build.device,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo build) {
    return <String, dynamic>{
      'brand': build.name,
      'device': build.systemName,
      'model': build.model,
      'manufacturer': build.systemName,
      'product': build.systemVersion,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FcmToken();
    initPlatformState();
    _connectionSubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        setState(
          () {
            if (event == ConnectivityResult.wifi ||
                event == ConnectivityResult.mobile) {
              AppConstants().showToast(msg: "Online");
            } else {
              AppConstants().showToast(msg: "No connection");
            }
          },
        );
      },
    );
  }
  void FcmToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    fcmToken = sharedPreferences.getString(AppStrings.FCM_TOKEN);
    print(fcmToken);
  }
  @override
  Widget build(BuildContext context) {
    final String defaultLocale = Platform.localeName;
    print("$defaultLocale");
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: _body(),
            ),
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
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 89,
                  ),
                  _signInText(),
                  SizedBox(height: 31),
                  CustomTextFormField(
                    controller: emailController,
                    hintText:
                        AppLocalizations.of(context).translate("emailHintText"),
                    obscureText: false,
                    validator: (value) {
                      if (!AppStrings.emailRegex.hasMatch(value)) {
                        return AppLocalizations.of(context)
                            .translate("emailValidationText");
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: AppLocalizations.of(context)
                        .translate("passWordHintText"),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate("passwordValidation");
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _remindMeSwitch(),
                  SizedBox(
                    height: 25,
                  ),
                  _loginButton(),
                  SizedBox(
                    height: 18,
                  ),
                  _bottomLineText()
                ],
              ),
            ),
          ),
          // _closeButton()
        ],
      ),
    );
  }

  _signInText() {
    return Text(
      AppLocalizations.of(context).translate("login"),
      style: AppTextStyles.bigTextStyle,
    );
  }

  _remindMeSwitch() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 22),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.55,
            child: CupertinoSwitch(
                dragStartBehavior: DragStartBehavior.start,
                value: isSwitchedOn,
                trackColor: Color(0xffBFBFBF),
                onChanged: (value) {
                  isSwitchedOn = value;
                  print(isSwitchedOn);
                  setState(() {});
                }),
          ),
          Expanded(
              child: Text(
            AppLocalizations.of(context).translate("remindMeText"),
            style: AppTextStyles.smallTextStyle,
          )),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context).translate("forgotPassText"),
              style: AppTextStyles.smallTextStyleWithColor,
            ),
          )
        ],
      ),
    );
  }

  _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: CustomButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _validationCheck();
          } else {
            print('Error');
          }
          // _validationCheck();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BottomNavigationBarView()),
          // );
        },
        text: AppLocalizations.of(context).translate("loginButtonText"),
      ),
    );
  }

  _bottomLineText() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: RichText(
        text: TextSpan(
            text:
                AppLocalizations.of(context).translate("DonhaveaccountUpText"),
            style: TextStyle(fontSize: 16, color: AppColors.purpleText_color),
            children: [
              TextSpan(
                  text: AppLocalizations.of(context).translate("signUpText"),
                  style: AppTextStyles.signUpTextStyle)
            ]),
      ),
    );
  }

  _closeButton() {
    return Container(
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
    );
  }

  _validationCheck() {
    if (emailController.text.trim().isEmpty) {
      AppConstants().showToast(
          msg: AppLocalizations.of(context).translate("emailValidationText"));
    } else if (passwordController.text.trim().isEmpty) {
      AppConstants().showToast(
          msg: AppLocalizations.of(context).translate("passwordValidation"));
    } else {
      loginApiCall(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
