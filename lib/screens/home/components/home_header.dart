import 'dart:async';
import 'dart:convert';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/screens/cart_unit_test/cart/cart_screen.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/screens/cart/cart_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:MakkiHerb/models/CartModel.dart' as CartData;
import '../../../constant/api_services.dart';
import '../../../models/widgetjson.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  final int itemCount;
  const HomeHeader({Key? key, required this.itemCount}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState(itemCount);
}

class _HomeHeaderState extends State<HomeHeader> {
  late SharedPreferences preferences;
  late String token;
  CartData.CartModel cartModel = CartData.CartModel(
      // message: "",
      data: CartData.Data(
          id: 0,
          customerEmail: "",
          customerFirstName: "",
          customerLastName: "",
          isGift: 0,
          itemsCount: 0,
          itemsQty: "",
          globalCurrencyCode: "",
          baseCurrencyCode: "",
          channelCurrencyCode: "",
          cartCurrencyCode: "",
          grandTotal: "0",
          formatedGrandTotal: "",
          baseGrandTotal: "",
          formatedBaseGrandTotal: "",
          subTotal: "",
          formatedSubTotal: "",
          baseSubTotal: "",
          formatedBaseSubTotal: "",
          taxTotal: "",
          formatedTaxTotal: "",
          baseTaxTotal: "",
          formatedBaseTaxTotal: "",
          discount: "",
          formatedDiscount: "",
          baseDiscount: "",
          formatedBaseDiscount: "",
          isGuest: 0,
          isActive: 0,
          items: [],
          createdAt: "",
          updatedAt: "",
          taxes: "",
          formatedTaxes: "",
          baseTaxes: "",
          formatedBaseTaxes: "",
          formatedDiscountedSubTotal: "",
          formatedBaseDiscountedSubTotal: ""));

  _HomeHeaderState(this.itemCount);
  int itemCount;
  // getCartData() async {
  //   preferences = await SharedPreferences.getInstance();
  //   this.token = preferences.getString("loggedIntoken").toString();

  //   if (this.token == "null") {
  //     // Fluttertoast.showToast(msg: "Please Login");
  //   } else {
  //     dynamic data = await APIService.GetCartItem(
  //         preferences.getString("loggedIntoken").toString());
  //     if (data['data'].length > 0) {
  //       setState(() {
  //         cartModel = CartData.CartModel.fromJson(data);
  //       });
  //     }
  //   }
  // }

  getCartData() async {
    print("cart Data");
    preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("loggedIntoken").toString();
    print("cart token");
    print(token);
    if (this.token == "null") {
      print("token");
      dynamic data = await APIService.GetCartItem("");
      print("cart Data");
      print(data);
      if (data.toString() != "null") {
        if (data['data'].length > 0) {
          print("oass cindition");
          setState(() {
            cartModel = CartData.CartModel.fromJson(data);
          });
        }
      }
    } else {
      dynamic data = await APIService.GetCartItem(
          preferences.getString("loggedIntoken").toString());
      print("cart Data");
      print(data);
      if (data.toString() != "null") {
        if (data['data'].length > 0) {
          setState(() {
            cartModel = CartData.CartModel.fromJson(data);
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      getCartData();
    });
    readJson();
  }

  widgetjson getjson = new widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SearchField(),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Search Icon.svg",
              color: getjson.banner.isNotEmpty
                  ? getjson.banner[0].iconColor
                  : kPrimaryColor,
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage())),
            ),
            SizedBox(
              width: 20,
            ),
            IconBtnWithCounter(
              svgSrc: Theme_Settings.HomeHeaderCartIcon,
              color: getjson.banner.length > 0
                  ? getjson.banner[0].iconColor
                  : kPrimaryColor,
              numOfitem: cartModel.data.itemsQty.isNotEmpty
                  ? int.parse(cartModel.data.itemsQty
                      .toString()
                      .substring(0, cartModel.data.itemsQty.indexOf(".")))
                  : 0,
              press: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartUnitTesting()));
              },
            ),
          ],
        ));
  }
}
