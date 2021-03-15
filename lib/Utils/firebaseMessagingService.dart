import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  BuildContext context;
  SharedPreferences sharedPreferences;
  var _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;
  var _lastOnResumeForFlushBar = DateTime.now().microsecondsSinceEpoch;

  FirebaseMessagingService(BuildContext context) {
    this.context = context;
  }

  getMessage() {
    if (Platform.isIOS) {
      firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {});
    }
    firebaseMessaging.getToken().then((token) {
      print(token);
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        if ((DateTime.now().microsecondsSinceEpoch - _lastOnResumeCall) >
            1000000) {
          _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;
          if (Platform.isIOS) {
            _onDidReceiveLocalNotification(false, message["data"]);
          } else if (Platform.isAndroid) {
            _onDidReceiveLocalNotification(false, message["data"]["data"]);
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        if ((DateTime.now().microsecondsSinceEpoch - _lastOnResumeCall) >
            1000000) {
          _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;
          if (Platform.isIOS) {
            _onDidReceiveLocalNotification(true, message["data"]);
          } else if (Platform.isAndroid) {
            _onDidReceiveLocalNotification(true, message["data"]["data"]);
          }
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        if ((DateTime.now().microsecondsSinceEpoch - _lastOnResumeCall) >
            1000000) {
          _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;
          if (Platform.isIOS) {
            _onDidReceiveLocalNotification(true, message["data"]);
          } else if (Platform.isAndroid) {
            _onDidReceiveLocalNotification(true, message["data"]["data"]);
          }
        }
      },
    );
  }

  Future _onDidReceiveLocalNotification(bool isResume, String data) async {
    // NotificationDetailData notification =
    // NotificationDetailData.fromJson(jsonDecode(data));
    sharedPreferences = await SharedPreferences.getInstance();
    if ((DateTime.now().microsecondsSinceEpoch - _lastOnResumeForFlushBar) >
        1000000) {
      _lastOnResumeForFlushBar = DateTime.now().microsecondsSinceEpoch;

    }
  }


}
