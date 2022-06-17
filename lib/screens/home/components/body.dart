import 'dart:async';
import 'dart:math';
import 'package:MakkiHerb/models/CartModel.dart' as CartData;
import 'package:MakkiHerb/screens/home/components/banner.dart';
import 'package:MakkiHerb/screens/home/components/flash_banner.dart';
import 'package:MakkiHerb/screens/home/components/flash_sale.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/DescendantCategory.dart';
import 'package:MakkiHerb/models/HomeSlider.dart';
import 'package:MakkiHerb/models/Productss.dart';
import 'package:MakkiHerb/screens/home/components/new_product.dart';
import 'package:MakkiHerb/screens/home/components/product_list.dart';
import 'package:MakkiHerb/screens/home/components/sub_category.dart';
import 'package:MakkiHerb/stuffs/sub_category.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:flutter/widgets.dart';
import 'package:MakkiHerb/widget/loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late double _progress;
  DescendantCategory subCat = DescendantCategory(data: []);
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
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
    configLoading();
    getCartData();
    _scrollController = ScrollController();
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {},
          ),
        ),
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;
  SubCatId subcatID = new SubCatId("0");

  void parentChange(newString) async {
// yeh sub cate ki id uth ke lar aye aur yahan pr function api subcategory
    dynamic data = await APIService.SubCategories(newString);
    DescendantCategory _subCat = DescendantCategory.fromJson(data);

    setState(() {
      subCat = _subCat;
      subcatID.catID = newString;
    });
  }

  late SharedPreferences preferences;
  String token = "";
  getCartData() async {
    preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("loggedIntoken").toString();

    if (this.token == "null") {
      dynamic data = await APIService.GetCartItem("");
      if (data.toString() != "null") {
        if (data['data'].length > 0) {
          setState(() {
            cartModel = CartData.CartModel.fromJson(data);
          });
        }
      }
    } else {
      dynamic data = await APIService.GetCartItem(
          preferences.getString("loggedIntoken").toString());

      if (data.toString() != "null") {
        if (data['data'].length > 0) {
          setState(() {
            cartModel = CartData.CartModel.fromJson(data);
          });
        }
      }
    }
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    //..customAnimation = CustomAnimation();
  }

  getProduct() async {
    products.clear();
    dynamic data = await APIService.HomePageSlider();

    HomeSlider slider_Data = HomeSlider.fromJson(data);

    for (var i = 0; i < slider_Data.data.length; i++) {
      setState(() {
        products.add(Productss(
            slider_Data.data[i].imageUrl.toString(),
            slider_Data.data[i].title.toString(),
            slider_Data.data[i].content.toString(),
            double.parse("0"),
            slider_Data.data[i].id.toString(),
            slider_Data.data[i].slider_product,
            slider_Data.data[i].slider_is));
      });
    }
  }

  List<Productss> products = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(itemCount: cartModel.data.itemsCount),
            SizedBox(height: getProportionateScreenWidth(20)),
            ProductList(
              products: products,
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const HomeBanner(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categories(
              setCatID: parentChange,
            ),
            SubCategories(
              id: subcatID,
              subcat: subCat,
              key: UniqueKey(),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            const FlashSaleBanner(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(name: "Featured"),
            SizedBox(height: getProportionateScreenWidth(30)),
            NewProducts(name: "New"),
            SizedBox(height: getProportionateScreenWidth(30)),
            FlashSale(name: "Flash")
          ],
        ),
      ),
    );
  }
}
