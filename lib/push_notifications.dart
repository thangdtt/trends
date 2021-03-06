import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:trends/ui/widgets/article/article_content.dart';
import 'package:trends/utils/utils_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/suggestArticle/suggestArticle_bloc.dart';
import 'data/saveArticle_repository.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init(BuildContext context, Function callback) async {
    Map<String, String> _getNotificationAndNavigate(
        Map<dynamic, dynamic> message, BuildContext context) {
      Map<String, String> notification = {
        'title': message['notification']['title'],
        'body': message['notification']['body'],
      };

      Map<String, String> data = {
        'click_action': message['data']['click_action'],
        'screen': message['data']['screen'],
        'articleId': message['data']['articleId'],
        'songId': message['data']['songId'],
      };

      return data;
    }

    if (!_initialized) {
      // For iOS request permission first.
      if (Platform.isIOS) {
        _firebaseMessaging
            .requestNotificationPermissions(IosNotificationSettings());
      }
      _firebaseMessaging.subscribeToTopic("topic1");

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

          var data = _getNotificationAndNavigate(message, context);

          switch (data['screen']) {
            case "Article":
              Navigator.of(context).popUntil((route) => route.isFirst);
              callback(0);
              await SavedArticleRepository.getSavedArticle(
                      int.parse(data['articleId']))
                  .then((value) {
                if (value != null) {
                  BlocProvider.of<SuggestArticleBloc>(context)
                      .add(FetchSuggestArticles(CategoryEnum.TinNong));
                  Navigator.of(context)
                      .pushNamed(ArticleContentWidget.routeName, arguments: {
                    'article': value,
                    'catEnum': CategoryEnum.TinNong,
                  });
                }
              });
              break;
            case "Music":
              Navigator.of(context).popUntil((route) => route.isFirst);
              callback(1);
              break;
            default:
              break;
          }
        },
      );

      // Future<void> _handleNotification(
      //     Map<dynamic, dynamic> message, bool dialog) async {
      //   var data = message['data'] ?? message;
      //   String expectedAttribute = data['expectedAttribute'];

      //   /// [...]
      // }

      // For testing purposes print the Firebase Messaging token
      // String token = await _firebaseMessaging.getToken();
      // print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
