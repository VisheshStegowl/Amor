// @dart=2.9
import 'dart:io';
import 'package:amor_93_7_fm/Utility/NotificationService.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:amor_93_7_fm/Screeens/LaunchScreen.dart';
import 'Utility/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC96gXT8rqh8srXTPp1VknxnnPPEjijLYE",
        appId: "1:281271204597:ios:95fde326f7bbd5ce4aa3bc",
        messagingSenderId: "281271204597",
        projectId: "amor-93-7-fm",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCYlRodIToqxY2_aeURUDiOKt6HQRvrKpM",
        appId: "1:281271204597:android:0de27d70545e47934aa3bc",
        messagingSenderId: "281271204597",
        projectId: "amor-93-7-fm",
      ),
    );
  }
  await FirebaseNotificationManager().init();
  await FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
  runApp(djangelsAppSTL());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class djangelsAppSTL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsFlutterBinding.ensureInitialized();
    return const djangelsApp();
  }
}

class djangelsApp extends StatefulWidget {
  const djangelsApp({Key key}) : super(key: key);

  @override
  _djangelsAppState createState() => _djangelsAppState();
}

class _djangelsAppState extends State<djangelsApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    notificationPermission();
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    // initMessaging();
    return MaterialApp(
      home: LaunchScreen(),
      theme: ThemeData(fontFamily: 'GOTHIC'),
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
    );
  }

  // void initMessaging() {
  //   var android = const AndroidInitializationSettings("ic_logo");
  //   var ios = const DarwinInitializationSettings();
  //   var setting = InitializationSettings(android: android, iOS: ios);
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin.initialize(setting);

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Message data: ${message.notification}');
  //     showNotification(message.notification);

  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  // }

  getToken() async {
    Constants.fmcToken = await messaging.getToken();
    print("FCM token is here ${Constants.fmcToken}");
  }

  // void showNotification(RemoteNotification notifi) async {
  //   var androidDetails = const AndroidNotificationDetails(
  //       "channelId", "channelName",
  //       icon:
  //           "ic_logo"); //AndroidNotificationDetails(notifi.title, "channelName");
  //   var iosDetails = const DarwinNotificationDetails();
  //   var generaldetails =
  //       NotificationDetails(iOS: iosDetails, android: androidDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, notifi.title, notifi.body, generaldetails,
  //       payload: "Notifications");
  // }

  void notificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
