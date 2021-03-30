
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingServiceInitialiation {

  FirebaseMessagingServiceInitialiation._();

  factory FirebaseMessagingServiceInitialiation() => _instance;

  static final FirebaseMessagingServiceInitialiation _instance = FirebaseMessagingServiceInitialiation._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      prefs.setString(AppStrings.FCM_TOKEN, token);



      _initialized = true;
    }
  }
}