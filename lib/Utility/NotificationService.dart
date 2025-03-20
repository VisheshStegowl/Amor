import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class FirebaseNotificationManager {
  static final _notification = FlutterLocalNotificationsPlugin();
  Future<FirebaseNotificationManager> init() async {
    _notification.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('ic_noti'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: (res) {});
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("aaa onMessageOpenedApp.listen");
    });
    FirebaseMessaging.onMessage.listen((message) async {
      //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      //       'sensual', 'jrtransportation',
      //       importance: Importance.max, priority: Priority.high);
      //   var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      //   var platformChannelSpecifics = NotificationDetails(
      //     android: androidPlatformChannelSpecifics,
      //     iOS: iOSPlatformChannelSpecifics,
      //   );
      //   await _notification.show(
      //       int.parse(DateFormat('MMddHHmm').format(DateTime.now())),
      //       message.notification.title,
      //       message.notification.body,
      //       platformChannelSpecifics,
      //       payload: jsonEncode(message.data));

      debugPrint("aaa onMessage.listen");
    });
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
    return this;
  }

  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      return Future.value(value ?? '');
    }).catchError((error) {
      return Future.value('');
    });
  }

  // Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //       'jrtransportation', 'jrtransportation',
  //       importance: Importance.max, priority: Priority.high);
  //   var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await _notification.show(
  //       int.parse(DateFormat('MMddHHmm').format(DateTime.now())),
  //       message.notification!.title,
  //       message.notification!.body,
  //       platformChannelSpecifics,
  //       payload: jsonEncode(message.data));
  // }
}

@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
  final _notification = FlutterLocalNotificationsPlugin();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDRwb3AJ5H1ByNbFeK8qFjhuf4qHEjxJbU",
        appId: "1:458821089853:ios:691e1d825737b0787d4854",
        messagingSenderId: "458821089853",
        projectId: "la-mega-94-9-fm",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDxazq6ncyRsd1J0ZbgUZgEMz59KeALoxQ",
        appId: "1:458821089853:android:066502b7b264010d7d4854",
        messagingSenderId: "458821089853",
        projectId: "la-mega-94-9-fm",
      ),
    );
  }

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channelId', 'AmorFm',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await _notification.show(
    int.parse(DateFormat('MMddHHmm').format(DateTime.now())),
    message.notification.title,
    message.notification.body,
    platformChannelSpecifics,
  );
}
