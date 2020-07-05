import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      if (Platform.isIOS) {
        _firebaseMessaging
            .requestNotificationPermissions(IosNotificationSettings());
      }

      _firebaseMessaging.configure(
        //Called in foreground
        onMessage: (Map<String, dynamic> message) async {
          print("On message: $message");
        },

        //Called when app completely closed and open when click on notification
        onLaunch: (Map<String, dynamic> message) async {
          print("On message: $message");
        },

        //Called when app in background and open when click on notification
        onResume: (Map<String, dynamic> message) async {
          //print("On message: $message");

          _getNotificationAndNavigate(message);
        },
      );

      Future<void> _handleNotification(
          Map<dynamic, dynamic> message, bool dialog) async {
        var data = message['data'] ?? message;
        String expectedAttribute = data['expectedAttribute'];

        /// [...]
      }

      // // For testing purposes print the Firebase Messaging token
      // String token = await _firebaseMessaging.getToken();
      // print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }

  void _getNotificationAndNavigate(Map<dynamic, dynamic> message) {
    var data = message['data'] ?? message;
    var view = data['view'];

    if (view != null) {
      if (view == "test") print("Data: ${data.view}");
      //Navigate to test
    }
  }
}
