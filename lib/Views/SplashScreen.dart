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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Brightness.dark);
    return Scaffold(
      body:
      AnnotatedRegion(child: _body(),value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:Brightness.dark),
      )
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      gotoIntro();
    });
  }

  gotoIntro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool("isRemindme")==null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
    } else{
    if (!sharedPreferences.getBool("isRemindme")) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarView()), (route) => false);

    }}}


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
