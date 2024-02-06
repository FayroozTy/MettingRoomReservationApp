import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reservation_app/Screen/BookingScreens/AdminsScreen/BookingFullListPage.dart';

import 'Screen/BookingScreens/AdminsScreen/AdminMainPage.dart';
import 'Screen/puplicScreens/MainPage.dart';
import 'Screen/puplicScreens/loginPage.dart';
import 'Widgets/backgroundWidget.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() { WidgetsFlutterBinding.ensureInitialized();
FirebaseMessaging.onBackgroundMessage(_firebaseMessaging);
  runApp(MyApp());
}

Future<void> _firebaseMessaging(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


class MyApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {

    // This widget is the root of your application.

    return MaterialApp(
      //builder: (context, child) => SafeArea(child: BookingListScreen()),
      debugShowCheckedModeBanner: false,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) =>  SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.

      },
      //home: Inform_List(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {

  late SharedPreferences prefs;

  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    getSharedPreferences ();
    registerNotification();

  }

  getSharedPreferences () async
  {
    prefs = await SharedPreferences.getInstance();
  }
  saveStringValue (String token) async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("FCMtoken", token);
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    Timer(
        const Duration(seconds: 4),
            () async =>{
          movenext()
        }

    );

    // TODO: implement build
    return Scaffold(


        body: Stack(
          children: <Widget>[
            background_Widget(),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child:
                   Image.asset('images/lg.png')
                      ),

                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFFF1F1F1),
                        fontFamily: "Al-Jazeera-Arabic-Bold"),
                  ),
                ),

              ],
            )
          ],
        ));
  }

  movenext() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? "false";
    String isAdmin = prefs.getString("isAdmin") ?? "false";


    if (isLogin == "false" ){

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  loginPage()),
      );



    } else {

      if (isAdmin == "false" ){


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  mainPage()),
        );

      }else{

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  AdminMainScreen()),
        );
     //   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AdminMainScreen()));
      }



     // mainPage()

      // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(0)));
    }
  }


  void registerNotification() async {




    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    _messaging.getToken().then((token){

      print('token: $token');
      saveStringValue (token.toString());

    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');


      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        print("getInitialMessage");


        if (message != null) {



        }


      });


      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

        print("FCMMessage");
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);



        final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

        final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

        final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);


        NotificationApi._notifications.initialize(initializationSettings,
            onSelectNotification: selectNotification );

        NotificationApi.showNotification(
            title: message.notification?.title, body: message.notification?.body, payload: 'notification');

      }
      );

      // For handling the received notifications(background)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

        print("FCMMessage2");
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);

        final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

        final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

        final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);


        NotificationApi._notifications.initialize(initializationSettings,
            onSelectNotification: selectNotification );

        NotificationApi.showNotification(
            title: message.notification?.title, body: message.notification?.body, payload: 'notification');








      });


    } else {
      print('User declined or has not accepted permission');
    }
  }

  ///Receive message when app is in background solution for on message




  Future<void>  selectNotification(String? x) async {

    print("test hear");



  }

}

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        channelShowBadge: true,

        icon: '@mipmap/ic_launcher',


        //<-- Add this parameter
      ),
      //iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}