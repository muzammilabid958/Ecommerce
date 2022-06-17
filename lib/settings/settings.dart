import 'package:MakkiHerb/constants.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class Theme_Settings {
  static Color DashboardBoxCashBack_Color = Color(0xFFFF7643);
  static Color colorWhite = Colors.white;

  static Map loaderColor = {"color": "#13743F"};
  static String AppName = "Wovista";
  static String HomeHeaderCartIcon = "assets/icons/Cart Icon.svg";
  static String HeartIcon = "assets/icons/Heart Icon_2.svg";
  static String ReciptIcon = "assets/icons/receipt.svg";
  static String TrashIcon = "assets/icons/Trash.svg";
  static String CameraIcon = "assets/icons/Camera Icon.svg";
  static const Map<String, dynamic> bodyColor = {"color": "#FFFF7643"};

  static const Map<String, dynamic> kPrimaryColor = {
    "BoxDecorationcolor": "#FFF",
    "TextColor": "#FFFF7643"
  };

  static TextStyle CashbackStyle = TextStyle(
    fontSize: getProportionateScreenWidth(24),
    fontWeight: FontWeight.bold,
  );

  static TextStyle A_Summer_Surpise_Style =
      TextStyle(fontStyle: FontStyle.italic);

  static BoxDecoration homePageSliderProductList = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(24)),
    // color: Color(0xffE99E22),
    gradient: LinearGradient(
      colors: <Color>[
        Color(0xfffc9918),
        Color(0xfffc9918),
        Color(0xfffc9918),
      ],
    ),
  );

  static List<Map<String, dynamic>> CategoryCardStyle = [
    {"CategoryCardPadding": "10.0"}
  ];

  static List<Map<String, dynamic>> subCategoryCardHome = [
    {"color": "f2f2f2"}
  ];

  static List<Map<String, dynamic>> featureProductListStyle = [
    {"BoxDecorationcolor": "#FFF", "TextColor": "#000000"}
  ];

  static Map<String, dynamic> iconBottomBar = {
    "home_icon": "assets/icons/Shop Icon.svg",
    "favorite_icon": "assets/icons/Heart Icon.svg",
    "category_icon": "assets/icons/categories_new.svg",
    "user_icon": "assets/icons/User Icon.svg",
  };

  static Map<String, dynamic> profilePageIcon = {
    "MyAccount": "assets/icons/User Icon.svg",
    "MyOrder": "assets/icons/Bill Icon.svg",
    "Support": "assets/icons/Question mark.svg",
    "Shiping": "assets/icons/Gift Icon.svg",
    "ChangePassword": "assets/icons/Settings.svg",
    "LogOut": "assets/icons/Log out.svg",
    "LogIn": "assets/icons/Log out.svg",
  };

  static Map<String, dynamic> socialIcon = {
    "google-icon": "assets/icons/google-icon.svg",
    "facebook-icon": "assets/icons/facebook-2.svg"
  };
}
