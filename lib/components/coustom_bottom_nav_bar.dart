import 'dart:convert';

import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/screens/category/category_screen.dart';
import 'package:MakkiHerb/screens/home/components/categories.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/profile/profile_screen.dart';
import 'package:MakkiHerb/screens/wishlistproducts/wishlist_product.dart';
import 'package:hexcolor/hexcolor.dart';
import '../constant/api_services.dart';
import '../constants.dart';
import '../enums.dart';
import '../models/widgetjson.dart';

class CustomBottomNavBar extends StatefulWidget {
  final MenuState selectedMenu;
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() =>
      _CustomBottomNavBarState(this.selectedMenu);
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late widgetjson getjson = widgetjson(banner: []);
  _CustomBottomNavBarState(
    this.selectedMenu,
  );

  final MenuState selectedMenu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: getjson.banner.length > 0
            ? HexColor(getjson.banner[0].bottomBarColor)
            : HexColor("#ebfcf3"),
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: getjson.banner.length > 0
                ? HexColor(getjson.banner[0].bottomBarColor).withOpacity(0.15)
                : HexColor("#ebfcf3"),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  Theme_Settings.iconBottomBar['home_icon'],
                  color: MenuState.home == selectedMenu
                      ? HexColor(getjson.banner.length > 0
                          ? getjson.banner[0].iconColor
                          : "#ebfcf3")
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Theme_Settings.iconBottomBar['favorite_icon'],
                  color: MenuState.favourite == selectedMenu
                      ? HexColor(getjson.banner.length > 0
                          ? getjson.banner[0].iconColor
                          : kPrimaryColor)
                      : inActiveIconColor,
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();

                  String userid =
                      preferences.getString("loggedIntoken").toString();

                  if (userid == "null") {
                    Fluttertoast.showToast(msg: "Please Login");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WishListProduct()));
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Theme_Settings.iconBottomBar['category_icon'],
                  color: MenuState.category == selectedMenu
                      ? HexColor(getjson.banner.length > 0
                          ? getjson.banner[0].iconColor
                          : kPrimaryColor)
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()),
                  );
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Theme_Settings.iconBottomBar['user_icon'],
                  color: MenuState.profile == selectedMenu
                      ? HexColor(getjson.banner.length > 0
                          ? getjson.banner[0].iconColor
                          : kPrimaryColor)
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
