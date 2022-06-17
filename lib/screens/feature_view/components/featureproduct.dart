import 'dart:convert';

import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:async_loader/async_loader.dart';
import 'package:MakkiHerb/models/AddToCart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/FeatureProduct.dart';
import 'package:MakkiHerb/models/WishListProduct.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class FeatureViewAllProduct extends StatefulWidget {
  static String routeName = "/FeatureViewAllProduct";
  String flag;
  FeatureViewAllProduct({
    Key? key,
    required this.flag,
  }) : super(key: key);

  @override
  _FeatureViewAllProductState createState() =>
      _FeatureViewAllProductState(this.flag);
}

class _FeatureViewAllProductState extends State<FeatureViewAllProduct> {
  late FeatureProduct product = new FeatureProduct(data: []);
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  String flag;

  _FeatureViewAllProductState(this.flag);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    readJson();
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();
    final data = await json.decode(jsondata);
    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: HexColor(Theme_Settings.loaderColor['color']),
                  )
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => new CustomScrollView(slivers: <Widget>[
              _buildPopularRestaurant(),
              // _buildPopularRestaurant(),
            ]));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          title: Text(
            "Feature Product ",
          ),
        ),
        body: _asyncLoader);
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();
    dynamic data = await APIService.FetaureSeeAll('?' + flag + '=1', token);
    print(data);
    setState(() {
      product = FeatureProduct?.fromJson(data);
    });
  }

  SliverGrid _buildPopularRestaurant() {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            id: product.data[index].id.toString(),
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: getProportionateScreenWidth(140),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  id: product.data[index].id.toString(),
                                )),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(20)),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              imageUrl:
                                  product.data[index].images[0].url.toString(),
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                color: Colors.green[800],
                              )),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/Placeholders.png'),
                            ),
                            // ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                            child: Text(
                          product.data[index].name.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                                child: Text(
                              "PKR " +
                                  product.data[index].price
                                      .toString()
                                      .substring(
                                          0,
                                          product.data[index].price
                                              .toString()
                                              .indexOf('.')),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(10),
                                fontWeight: FontWeight.w600,
                                color: HexColor(getjson.banner.isNotEmpty
                                    ? getjson.banner[0].primaryColor
                                    : kPrimaryColor),
                              ),
                            )),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String userID =
                                    preferences.getString("UserID").toString();

                                if (userID == "null") {
                                  AddToCartModel cartModel = new AddToCartModel(
                                      productId:
                                          product.data[index].id.toString(),
                                      quantity: "1");
                                  dynamic data =
                                      await APIService.AddToCart(cartModel, "");

                                  Fluttertoast.showToast(
                                      msg: data['message'].toString());
                                } else {
                                  AddToCartModel cartModel = new AddToCartModel(
                                      productId:
                                          product.data[index].id.toString(),
                                      quantity: "1");
                                  dynamic data = await APIService.AddToCart(
                                      cartModel,
                                      preferences
                                          .getString('loggedIntoken')
                                          .toString());
                                  print(data);
                                  setState(() {});
                                  // CartModel cartResponseModel =
                                  //     CartModel.fromJson(json.decode(data));

                                  Fluttertoast.showToast(
                                      msg: data['message'].toString());
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(8)),
                                height: getProportionateScreenWidth(28),
                                width: getProportionateScreenWidth(28),
                                decoration: BoxDecoration(
                                  color: true
                                      ? HexColor(getjson.banner.isNotEmpty
                                              ? getjson.banner[0].iconColor
                                              : kPrimaryColor)
                                          .withOpacity(0.15)
                                      : kSecondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Cart Icon.svg",
                                  // color: product.data[index].isWishlisted
                                  //     ? Color(0xFFFF4848)
                                  //     : Color(0xFFDBDEE4),
                                ),
                              ),
                            ),
                            if (1 != "null") ...[
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String userID = preferences
                                      .getString("UserID")
                                      .toString();

                                  String token = preferences
                                      .getString("loggedIntoken")
                                      .toString();

                                  dynamic data = await APIService.WishlistItem(
                                      product.data[index].id.toString(),
                                      userID,
                                      token);
                                  print("dsds");
                                  Fluttertoast.showToast(msg: data['message']);

                                  setState(() {
                                    getData();
                                  });

                                  // setState(() {
                                  //   getFeaturedProduct();
                                  // });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(8)),
                                  height: getProportionateScreenWidth(40),
                                  width: getProportionateScreenWidth(35),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color:
                                        product.data[index].isWishlisted == true
                                            ? Color(0xFFFF4848)
                                            : Color(0xFFDBDEE4),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        }, childCount: product.data.length));
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }
}
