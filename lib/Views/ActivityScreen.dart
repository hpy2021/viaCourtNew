import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/Applocalization.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Utils/firebaseMessagingService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<NotificationList> notificationList = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  SharedPreferences prefs;

  _register() async {
    prefs = await SharedPreferences.getInstance();
    _firebaseMessaging
        .getToken()
        .then((token) => print("this is the token of the fcm  $token"));
  }

  List<String> titleList = [];
  List<String> bodyList = [];
  bool isSetValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTitles();
    // notificationList.add(
    //   NotificationList(
    //       time: "1 minute ago",
    //       title: "Booking notification",
    //       subtitle:
    //           "Lorem ipsum, or lipsum as it is sometimes known, is dmy text used in laying out print, graphic or web designs."),
    // );
    // notificationList.add(
    //   NotificationList(
    //       time: "Monday at 10:14",
    //       title: "Booking",
    //       subtitle:
    //           "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs."),
    // );
    // notificationList.add(
    //   NotificationList(
    //       time: "Sunday at 7:14",
    //       title: "Notifications",
    //       subtitle:
    //           "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs."),
    // );
    _register();
    getMessage();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      // notificationList.add(
      //   NotificationList(
      //     title: message["notification"]["title"],
      //     subtitle: message["notification"]["body"],
      //     time: DateTime
      //         .now()
      //         .millisecondsSinceEpoch
      //         .toString(),
      //   ),
      // );
      setState(() {
        notificationList.add(
          NotificationList(
            title: message["notification"]["title"],
            subtitle: message["notification"]["body"],
            time: DateTime.now().millisecondsSinceEpoch.toString(),
          ),
        );
        titleList.add(message["notification"]["title"]);
        print("this is the length of the titleList${titleList.length}");
        // prefs.setBool(key, value)
        prefs
            .setStringList(AppStrings.NotificationStringListTitle, titleList)
            .whenComplete(() {
          prefs.setBool("isSet", true);
        });
        // bodyList.add(message["notification"]["body"]);
        // prefs.setStringList(AppStrings.NotificationStringListbody, bodyList);
        // print("this is the saved string ${prefs.getString(AppStrings.NotificationStringListTitle)}");
      });
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      if (mounted)
        setState(() => _messageText = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      if (mounted)
        setState(() => _messageText = message["notification"]["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // getMessage();
    return Scaffold(
      body: _buildBody(context),
    );
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
          AppConstants().header(
              text: AppLocalizations.of(context).translate("activityText"),
              context: context),
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
        children: [Expanded(child: _activitylist())],
      ),
    ));
  }

  _activitylist() {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: titleList.length,
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(7),
                // color: Colors.white,
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
            // boxShadow: [
            //   BoxShadow(
            //       offset: Offset(0, 1),
            //       color: Colors.black45,
            //       blurRadius: 5)
            // ]),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              title: Text(
                "${titleList[index]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "{notificationList[index].subtitle}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("{notificationList[index].time}"),
                ],
              ),
              trailing: Container(
                margin: EdgeInsets.only(right: 10),
                height: 10,
                width: 10,
                decoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<String>> getTitles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSetValue = prefs.getBool("isSet");
    print("this is in get title$isSetValue");
    if (isSetValue != null) {
      if (isSetValue) {
        if (mounted)
          setState(() {
            titleList.addAll(
                prefs.getStringList(AppStrings.NotificationStringListTitle));
          });
      }
    }
    return prefs.getStringList(AppStrings.NotificationStringListTitle);
  }

  Future<List<String>> getMsgs(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList(AppStrings.NotificationStringListbody);
    return prefs.getStringList(AppStrings.NotificationStringListbody);
  }
}

class NotificationList {
  String title;
  String subtitle;
  String time;

  NotificationList({this.title, this.subtitle, this.time});
}
