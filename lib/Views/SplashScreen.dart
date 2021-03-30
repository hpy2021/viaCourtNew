import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Views/BottomNavigationBarHome.dart';
import 'package:my_app/Views/SelectCourtSizeScreen.dart';
import 'package:my_app/Views/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isfirst = true;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // showAlertDialog(context);
    // selectedLanguage = Platform.localeName == "en" ? AppStrings.engLanuage:AppStrings.arabicLanguage;
    // if (!Platform.localeName.contains("en")) {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (_) async {
    //       await showDialog<String>(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (BuildContext context) => new AlertDialog(
    //           title: new Text(
    //             "Language change",
    //             style: TextStyle(
    //                 color: AppColors.home_gradient2, letterSpacing: 0.5),
    //           ),
    //           content: new Text(
    //               "Are you sure you want to change the language to arabic ?. Once you changed the language you cannot be able to change from the app"),
    //           actions: <Widget>[
    //             new MaterialButton(
    //               child: new Text("Confirm"),
    //               textColor: AppColors.home_gradient2,
    //               onPressed: () {
    //                 if (!Platform.localeName.contains("en")) {
    //                   // selectedLanguage = AppStrings.arabicLanguage;
    //                   EasyLocalization.of(context).setLocale(
    //                       EasyLocalization.of(context).supportedLocales[1]);
    //                 }
    //                 if (mounted) setState(() {});
    //                 Navigator.of(context).pop();
    //                 navigate();
    //               },
    //             ),
    //             new MaterialButton(
    //               textColor: AppColors.home_gradient2,
    //               child: new Text("Cancel"),
    //               onPressed: () {
    //                 // print("in the cancel on pressed : $selectedLanguage");
    //                 if (!Platform.localeName.contains("en")) {
    //                   print("in if else");
    //                   // selectedLanguage = AppStrings.arabicLanguage;
    //                   EasyLocalization.of(context).setLocale(
    //                       EasyLocalization.of(context).supportedLocales[0]);
    //                 }
    //                 if (mounted) setState(() {});
    //                 Navigator.of(context).pop();
    //                 navigate();
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // } else {
      navigate();
    // }

    //
  }

  _checkingLocale()async {
    prefs = await SharedPreferences.getInstance();
    if(!Platform.localeName.contains("en")) {

    }
    if(prefs.getBool(AppStrings.LANGUAGECHANGE)){
      navigate();
    }else {
      if (!Platform.localeName.contains("en")) {
        WidgetsBinding.instance.addPostFrameCallback(
              (_) async {
            await showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => new AlertDialog(
                title: new Text(
                  "Language change",
                  style: TextStyle(
                      color: AppColors.home_gradient2, letterSpacing: 0.5),
                ),
                content: new Text(
                    "Are you sure you want to change the language to arabic ?. Once you changed the language you cannot be able to change from the app"),
                actions: <Widget>[
                  new MaterialButton(
                    child: new Text("Confirm"),
                    textColor: AppColors.home_gradient2,
                    onPressed: () {
                      if (!Platform.localeName.contains("en")) {
                        // selectedLanguage = AppStrings.arabicLanguage;
                        EasyLocalization.of(context).setLocale(
                            EasyLocalization.of(context).supportedLocales[1]);
                      }
                      if (mounted) setState(() {});
                      Navigator.of(context).pop();
                      navigate();
                    },
                  ),
                  new MaterialButton(
                    textColor: AppColors.home_gradient2,
                    child: new Text("Cancel"),
                    onPressed: () {
                      // print("in the cancel on pressed : $selectedLanguage");
                      if (!Platform.localeName.contains("en")) {
                        print("in if else");
                        // selectedLanguage = AppStrings.arabicLanguage;
                        EasyLocalization.of(context).setLocale(
                            EasyLocalization.of(context).supportedLocales[0]);
                      }
                      if (mounted) setState(() {});
                      Navigator.of(context).pop();
                      navigate();
                    },
                  ),
                ],
              ),
            );
          },
        );
      } else {
        navigate();
      }
    }

  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("My title"),
          content: Text("This is my message."),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {},
            )
          ],
        );
      },
    );
  }

  bool _tryAgain = true;

  @override
  Widget build(BuildContext context) {
    // var body = Container(
    //   alignment: Alignment.center,
    //   child: _tryAgain
    //       ? MaterialButton(
    //       child: Text("Try again"),
    //       onPressed: () {
    //         showAlertDialog(context);
    //       })
    //       : Text("This device is connected to Wifi"),
    // );

    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    return Scaffold(
        body: AnnotatedRegion(
      child: _body(),
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    ));
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      gotoIntro();
    });
  }

  gotoIntro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("isRemindme") == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } else {
      if (!sharedPreferences.getBool("isRemindme")) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarView(
                      selectedIndex: 0,
                    )),
            (route) => false);
      }
    }
  }

  _body() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors().gradient()),
      child: Center(
        child: Image.asset(
          "assets/images/appLogo.png",
          height: 167,
          width: 177,
        ),
      ),
    );
  }
}
