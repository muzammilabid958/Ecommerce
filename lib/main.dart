import 'dart:convert';
import 'dart:io';
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/billing_stepper/billing_stepper.dart';
import 'package:MakkiHerb/screens/category/product_category_screen.dart';
import 'package:MakkiHerb/screens/serverError.dart';
import 'package:MakkiHerb/settings/darkMode.dart';
import 'package:MakkiHerb/settings/darkModeStyle.dart';
import 'package:MakkiHerb/settings/theme_json.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/routes.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:MakkiHerb/screens/Billing_Recipt/unpaid_page.dart';
import 'package:MakkiHerb/screens/home/components/categories.dart';
import 'package:MakkiHerb/screens/order_success/order_success_screen.dart';
import 'package:MakkiHerb/screens/orders/orders.dart';
import 'package:MakkiHerb/screens/shipment/shipping_list.dart';
import 'package:MakkiHerb/screens/splash/splash_screen.dart';
import 'package:MakkiHerb/theme.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'models/FirebaseModel.dart';
import 'screens/category/sliderProduct.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.high);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    initialMessage = message;
    Fluttertoast.showToast(msg: message!.data.length.toString());
  });

  // onMessage: When the app is open and it receives a push notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    initialMessage = message;
    Fluttertoast.showToast(msg: message.data.length.toString());
  });

  // replacement for onResume: When the app is in the background and opened directly from the push notification.

  APIService.loaded_from_firebase = true;
}

String key = "is_product";
RemoteMessage? initialMessage;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  HttpOverrides.global = MyHttpOverrides();
  ThemeData themeData = await initializeThemeData();
  runApp(MyApp(themeData: themeData));
}

Future<ThemeData> initializeThemeData() async {
  final jsondata = await APIService.jsonfile();

  widgetjson widget = widgetjson.fromJson(jsondata);

  return ThemeData(
    scaffoldBackgroundColor:
        HexColor(widget.banner[0].scaffoldBackgroundColor.toString()),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.getFont(
          widget.banner.isNotEmpty
              ? widget.banner[0].bodyText1.toString()
              : "Poppins",
          color: HexColor(widget.banner[0].textcolor1.toString())),
      color: HexColor(widget.banner[0].appbarbackgroundcolor.toString()),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.red),
    textTheme: TextTheme(
        button: GoogleFonts.getFont(
            widget.banner[0].bodyText1.toString().isNotEmpty
                ? widget.banner[0].bodyText1.toString()
                : "Poppins",
            color: HexColor(widget.banner[0].textcolor1.toString())),
        bodyText1: GoogleFonts.getFont(
            widget.banner[0].bodyText1.toString().isNotEmpty
                ? widget.banner[0].bodyText1.toString()
                : "Poppins",
            color: HexColor(widget.banner[0].textcolor1.toString())),
        bodyText2: GoogleFonts.getFont(
            widget.banner[0].bodyText2.toString().isNotEmpty
                ? widget.banner[0].bodyText2.toString()
                : "Poppins",
            color: HexColor(widget.banner[0].textcolour2.toString()))),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  final ThemeData? themeData;

  const MyApp({Key? key, this.themeData}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState(themeData);
}

class _MyAppState extends State<MyApp> {
  @override
  widgetjson getjson = widgetjson(banner: []);

  dynamic fontfamily1 = "Poppins";
  dynamic fontfamily2 = "Poppins";
  dynamic fontcolour;
  static dynamic themebackgroundcolor = "";
  dynamic appbarcolor;
  dynamic buttoncolor;
  final ThemeData? themeData;
  _MyAppState(this.themeData);

  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      String slider = message!.data["slider_is"].toString();

      Fluttertoast.showToast(msg: slider);
      if (slider == 'is_flashsale') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SliderProduct(
                    id: message.data["slider_product"].toString(),
                  )),
        );
      }
      if (slider == 'is_category') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryAllProduct(
                  id: message.data["slider_product"].toString())),
        );
      }
      if (slider == 'slider_product') {}
      if (slider == 'is_product') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    id: message.data["slider_product"].toString(),
                  )),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: "Makki Herbals",
        routes: routes,
        builder: EasyLoading.init(),
        navigatorKey: NavigationService.navigationKey,
        theme: themeData ?? ThemeData.dark());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = ((cert, host, port) => true);
  }
}
