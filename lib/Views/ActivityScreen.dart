import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Utils/firebaseMessagingService.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<NotificationList> notificationList = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationList.add(
      NotificationList(
          time: "1 minute ago",
          title: "Booking notification",
          subtitle:
              "Lorem ipsum, or lipsum as it is sometimes known, is dmy text used in laying out print, graphic or web designs."),
    );
    notificationList.add(
      NotificationList(
          time: "Monday at 10:14",
          title: "Booking",
          subtitle:
              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs."),
    );
    notificationList.add(
      NotificationList(
          time: "Sunday at 7:14",
          title: "Notifications",
          subtitle:
              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs."),
    );
    _register();
    getMessage();

  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          notificationList.add(NotificationList(
            title: message["notification"]["title"],
            subtitle: message["notification"]["body"],time: DateTime.now().millisecondsSinceEpoch.toString()
          ));
          if(mounted)
         setState(() {

         });
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _messageText = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _messageText = message["notification"]["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    getMessage();
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
          AppConstants()
              .header(text: tr("activityText"), context: context),
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
        itemCount: notificationList.length,
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
                "${notificationList[index].title}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${notificationList[index].subtitle}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${notificationList[index].time}"),
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
}

class NotificationList {
  String title;
  String subtitle;
  String time;

  NotificationList({this.title, this.subtitle, this.time});
}
