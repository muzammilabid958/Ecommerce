import 'dart:convert';
import 'dart:io';
// import 'package:connectivity/connectivity.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/chat_unit/chat-unit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/slide.dart';
import 'package:MakkiHerb/screens/complete_profile/complete_profile_screen.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:MakkiHerb/size_config.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_loader/awesome_loader.dart';
// This is the best practice
import '../../../constant/api_services.dart';
import '../../../settings/settings.dart';
import '../../../settings/theme_json.dart';
import '../../category/product_category_screen.dart';
import '../../category/sliderProduct.dart';
import '../../details/details_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 0;
  final Connectivity _connectivity = Connectivity();
  int userID = 0;
  Map _source = {ConnectivityResult.none: false};
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    readJson();

    String slider = "";
    String sliderProduct = "";

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      slider = message!.data["slider_is"].toString();
      sliderProduct = message.data["slider_product"].toString();
    });

    Timer(const Duration(seconds: 3), () {
      if (slider == 'is_flashsale') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SliderProduct(
                    id: sliderProduct,
                  )),
        );
      } else if (slider == 'is_category') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryAllProduct(id: sliderProduct)),
        );
      } else if (slider == 'slider_product') {
      } else if (slider == 'is_product') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    id: sliderProduct,
                  )),
        );
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
    getData();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    print("hello");
    getToken();
  }

  ConnectivityResult result = ConnectivityResult.none;
  String _connectionStatus = 'Unknown';

  widgetjson getjson = new widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
      ReadJsonForTheme.themebackgroundcolor =
          getjson.banner[0].scaffoldBackgroundColor.toString();
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print(message.data);
  }

  Future<void> initConnectivity() async {
    try {
      result = await _connectivity.checkConnectivity();
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(result);
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Internet Disconnected,Please check your connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print("online");
    }
  }

  getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("dsds");
    if (preferences.getString("UserID").toString().isNotEmpty ||
        preferences.getString("UserID").toString() != "null") {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    print("Notification Token");
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: slidelist.length,
                itemBuilder: (context, index) => SplashContent(
                  image: slidelist[index].imageURL,
                  text: slidelist[index].description,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        slidelist.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader3,
                      color: getjson.banner.length > 0
                          ? HexColor(getjson.banner[0].primaryColor)
                          : HexColor(kPrimaryColor),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        // color: _currentPage == index
        //     ? HexColor(getjson.banner[0].primaryColor)
        //     : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
