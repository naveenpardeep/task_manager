// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NsgPushNotificationService {
//   static NsgPushNotificationService? _instance;
//   Function(RemoteMessage)? messageReceiver;

//   NsgPushNotificationService._();

//   static NsgPushNotificationService get instance => _instance ??= NsgPushNotificationService._();

//   String firebasetoken = '';

//   late FirebaseMessaging _firebaseMessaging;

//   NsgPushNotificationService();

//   Future initialize() async {
//     try {
//       if (!Platform.isIOS && !Platform.isAndroid) return;
//       await Firebase.initializeApp();
//       _firebaseMessaging = FirebaseMessaging.instance;
//       //var settings =
//       await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       //Обработка сообщений, полученных до запуска программы
//       FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//         if (message != null) {
//           _handleMessage(message);
//           /*if (messageReceiver != null) {
//             messageReceiver!(message);
//           }*/
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => _handleMessage(message)); //////////////////

//       //Обработка сообщений, полученных во время работы программы
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         if (messageReceiver != null) {
//           messageReceiver!(message);
//         }
//       });

//       // If you want to test the push notification locally,
//       // you need to get the token and input to the Firebase console
//       // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
//       String? token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         firebasetoken = token;
//       }
//       //firebase token - необходимо отправить на сервер после инициализации сессии
//       //Теоретически, может изменяться при каждом запуске программы
//     } catch (e) {
//       debugPrint('Firebase не инициализирован');
//     }
//   }

//   void _handleMessage(RemoteMessage message) async {
//     /////////////////////
//     if (message.data['Id'] != null && message.data['Id'] != '000000') {}
//   }
// }
