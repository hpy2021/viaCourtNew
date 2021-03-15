import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Views/ActivityScreen.dart';
import 'package:my_app/Views/BookingScreen.dart';
import 'package:my_app/Views/SelectCourtSizeScreen.dart';
import 'package:my_app/Views/ProfileScreen.dart';
import 'package:my_app/Views/HomeScreen.dart';

class BottomNavigationBarView extends StatefulWidget {
  @override
  _BottomNavigationBarViewState createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  Widget _widget = SelectCourtSize();
  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    if (mounted)
      setState(() {
        _selectedIndex = index;
      });
    switch (index) {
      case 0:
        changewidget(SelectCourtSize());
        break;
      case 1:
        changewidget(BookingScreen());
        break;
      case 2:
        changewidget(ActivityScreen());
        break;
      case 3:
        changewidget(ProfileScreen());
        break;
    }
  }

  changewidget(Widget widget) {
    if (mounted) {
      setState(() {
        _widget = widget;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: _widget,
              ),
            ],
          ),
        ),
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  _bottomBar() {
    return Container(
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
            color: AppColors.bottomNavigationBarTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w500),
        selectedLabelStyle: TextStyle(
            color: Colors.black, fontSize: 11, fontWeight: FontWeight.w500),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: AppStrings.homeText,
            activeIcon: Image.asset(
              "assets/images/Home.png",
              width: 27,
              height: 25,
            ),
            icon: Image.asset(
              "assets/images/Home.png",
              width: 27,
              height: 25,
              color: Color(0xff707070),
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.bookingText,
            icon: Image.asset(
              "assets/images/ticket.png",
              width: 27,
              height: 25,
            ),
            activeIcon: Image.asset(
              "assets/images/ticket.png",
              width: 27,
              height: 25,
              color: AppColors.appColor_color,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.activityText,
            icon: Image.asset(
              "assets/images/activity.png",
              width: 27,
              height: 25,
            ),
            activeIcon: Image.asset(
              "assets/images/activity.png",
              width: 27,
              height: 25,
              color: AppColors.appColor_color,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.meText,
            icon: Image.asset(
              "assets/images/user.png",
              width: 27,
              height: 25,
            ),
            activeIcon: Image.asset(
              "assets/images/user.png",
              width: 27,
              height: 25,
              color: AppColors.appColor_color,
            ),
          ),
        ],
      ),
    );
  }
}


