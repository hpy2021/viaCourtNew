import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Views/ChangePassword.dart';
import 'package:my_app/Views/terms&pp/commonFile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/SignUpResposne.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/EditProfile.dart';
import 'package:my_app/Views/LoginScreen.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Utils/firebaseMessagingService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserResponse user;
  bool isLoading = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userApiCall();
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     setState(() {
    //       _messageText = "Push Messaging message: $message";
    //     });
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     setState(() {
    //       _messageText = "Push Messaging message: $message";
    //     });
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     setState(() {
    //       _messageText = "Push Messaging message: $message";
    //     });
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   setState(() {
    //     _homeScreenText = "Push Messaging token: $token";
    //   });
    //   print(_homeScreenText);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: _buildBody(context),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  userApiCall() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      UserResponse registerResponse = UserResponse.fromJson(
          await ApiManager().getCallwithheader(AppStrings.USER_URL));

      if (registerResponse.status == "Active") {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        print(registerResponse.firstname);
        user = registerResponse;
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

  logoutApiCall() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, Object> request = new HashMap();
      print("222");
      CommonResponse registerResponse = CommonResponse.fromJson(
        await ApiManager()
            .postCallWithHeader(AppStrings.LOGOUT_URL, request, context),
      );
      print("223");
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (registerResponse.status == 204) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        print("224");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        // print(registerResponse.firstname);
        // user = registerResponse;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        setState(() {});
        AppConstants().showToast(msg: "Logout");
      } else {
        print("225");

        if (mounted)
          setState(() {
            isLoading = false;
          });
        // AppConstants().showToast(msg: "${registerResponse.message}");
      }
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

  _buildBody(context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors().homegradient()),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          user == null
              ? header("user", context)
              : header("${user.firstname + " " + user.lastname}", context),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: profileView(),
            ),
          ],
        ),
      ),
    );
  }

  header(String text, context) {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => EditProfile(user: user,)));
        },
        child: Row(
          children: [
            // Container(
            //   height: 56,
            //   width: 56,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       image: DecorationImage(
            //           image: AssetImage("assets/images/profile.jpg"))),
            // ),
            SizedBox(width: 16),
            Text(
              text,
              style: AppTextStyles.textStyle25white,
            ),
          ],
        ),
      ),
    );
  }

  profileView() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 22),
      children: [
        SizedBox(
          height: 37,
        ),
        _textIconWidget(
            text: tr("myProfileText"),
            url: "assets/images/profile.png",
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfile(
                          user: user,
                        )))),
        SizedBox(
          height: 34,
        ),
        _textIconWidget(
            text: tr("changePasswordText"),
            url: "assets/images/lock.png",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePassword(),
                ),
              );
            }),
        SizedBox(
          height: 34,
        ),
        _textIconWidget(text: tr("myBookingsText"), url: "assets/images/ticket.png"),
        SizedBox(
          height: 34,
        ),
        _textIconWidget(
          text: tr("termsandconditionText"),
          url: "assets/images/doc.png",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Termsandprivacy(isFromprivacypolicy: false,),
            ),
          ),
        ),
        SizedBox(
          height: 34,
        ),
        _textIconWidget(
          text: tr("privacyPolicyText"),
          url: "assets/images/pp.png",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Termsandprivacy(isFromprivacypolicy: true,),
            ),
          ),
        ),
        SizedBox(
          height: 34,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0xffBAC0DA),
        ),
        SizedBox(
          height: 32,
        ),
        _textIconWidget(
            text: tr("logoutText"),
            url: "assets/images/signout.png",
            onPressed: () async {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.clear();
              if (mounted)
                setState(() {
                  isLoading = true;
                });
              Map<String, Object> request = new HashMap();
              CommonResponse registerResponse = CommonResponse.fromJson(
                await ApiManager().postCallWithHeader(
                    AppStrings.LOGOUT_URL, request, context),
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              print(registerResponse.result);
              if (mounted)
                setState(() {
                  isLoading = false;
                });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
              AppConstants().showToast(msg: "Logout");
            }),
      ],
    );
  }

  _textIconWidget({String url, String text, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Image.asset(
              "$url",
              height: 20.7,
              width: 20.7,
              color: AppColors.lightGreenText_color,
            ),
            SizedBox(
              width: 11.3,
            ),
            Text(
              text,
              style: AppTextStyles.textStyle18,
            )
          ],
        ),
      ),
    );
  }
}
