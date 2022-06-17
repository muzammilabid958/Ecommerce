import 'dart:convert';

import 'package:MakkiHerb/settings/settings.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/AddToCart.dart';
import 'package:MakkiHerb/models/CartModel.dart';
import 'package:MakkiHerb/models/CategoryProduct.dart';
import 'package:MakkiHerb/models/FeatureProduct.dart';
import 'package:MakkiHerb/models/WishListProduct.dart' as WishListModelClass;
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/widgetjson.dart';

class WishListProduct extends StatefulWidget {
  static String routeName = "/WishListProduct";

  WishListProduct({
    Key? key,
  }) : super(key: key);

  @override
  _WishListProductState createState() => _WishListProductState();
}

class _WishListProductState extends State<WishListProduct> {
  late WishListModelClass.WishListProduct product =
      WishListModelClass.WishListProduct(
    data: [],
  );
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  _WishListProductState();
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
    final data = json.decode(jsondata);
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
        renderSuccess: ({data}) => product.data!.isNotEmpty
            ? new CustomScrollView(slivers: <Widget>[
                _buildPopularRestaurant(),
                // _buildPopularRestaurant(),
              ])
            : Center(
                child: Text("Empty"),
              ));
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          title: Text(
            "Wishlist Product",
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.favourite),
        body: _asyncLoader);
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.wishListGet(token);
    print(data);

    product = WishListModelClass.WishListProduct.fromJson(data);
  }

  _buildPopularRestaurant() {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  width: getProportionateScreenWidth(140),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailScreen(
                      //             id: product.data[index].id.toString(),
                      //           )),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(20)),
                            // decoration: BoxDecoration(
                            //   color: kSecondaryColor.withOpacity(0.1),
                            //   borderRadius: BorderRadius.circular(15),
                            // ),

                            child: CachedNetworkImage(
                              // imageUrl: Config.imageBaseURL +
                              //     "storage/" +
                              //     product.data[index].imageUrl.toString(),
                              imageUrl: product
                                  .data![index].product!.images![0].url
                                  .toString(),
                              placeholder: (context, url) => new Center(
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
                        Flexible(
                          child: new Container(
                            child: new Center(
                                child: new Text(
                              product.data![index].product!.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                color: new Color(0xFF212121),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: new Container(
                                child: new Center(
                                    child: new Text(
                                  "PKR " +
                                      product.data![index].product!.price
                                          .toString()
                                          .substring(
                                              0,
                                              product
                                                  .data![index].product!.price
                                                  .toString()
                                                  .indexOf('.')),
                                  // overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: new Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String userID =
                                    preferences.getString("UserID").toString();

                                if (userID == "null") {
                                  Fluttertoast.showToast(
                                      msg: "Please Login First");
                                } else {
                                  dynamic data =
                                      await APIService.WishlistToCart(
                                          product.data![index].id.toString(),
                                          preferences
                                              .getString('loggedIntoken')
                                              .toString());

                                  // CartModel cartResponseModel =
                                  //     CartModel.fromJson(json.decode(data));

                                  Fluttertoast.showToast(
                                      msg: "Item Added Cart Succesfully");
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
                                              ? getjson.banner[0].primaryColor
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
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String userID =
                                    preferences.getString("UserID").toString();

                                if (userID == "null") {
                                  Fluttertoast.showToast(
                                      msg: "Please Login First");
                                } else {
                                  String token = preferences
                                      .getString('loggedIntoken')
                                      .toString();
                                  dynamic data =
                                      await APIService.removeToWishList(token,
                                          product.data![index].id.toString());
                                  print(data);
                                  Fluttertoast.showToast(msg: data['message']);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget));
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
                                              ? getjson.banner[0].primaryColor
                                              : kPrimaryColor)
                                          .withOpacity(0.15)
                                      : kSecondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Trash.svg",
                                  // color: product.data[index].isWishlisted
                                  //     ? Color(0xFFFF4848)
                                  //     : Color(0xFFDBDEE4),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
            //childCount: product.data.length
            childCount: product.data!.length));
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }
}
