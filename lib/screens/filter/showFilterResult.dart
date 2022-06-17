import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/filterid.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../models/AddToCart.dart';
import '../../models/FilteredProduct.dart';
import '../../models/widgetjson.dart';
import '../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:async_loader/async_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class ShowFilterData extends StatefulWidget {
  List<String> id;
  List<String> price;
  ShowFilterData({Key? key, required this.id, required this.price})
      : super(key: key);

  @override
  _ShowFilterDataState createState() =>
      _ShowFilterDataState(this.id, this.price);
}

class _ShowFilterDataState extends State<ShowFilterData> {
  late List<String> id = [];
  late List<String> price = [];
  _ShowFilterDataState(this.id, this.price);
  late FilteredProduct product = new FilteredProduct(data: []);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // filterid selectedids = new filterid();

    // getData(selectedids);
    getData();
    print("Length");
    print(product.data.length);
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

  getData() async {
    List<String> c = [];
    List<String> priceList = [];
    String selectedid = "";
    String selectedprice = "";
    print("Price Selected ");
    print(price);
    print("ID Selected ");
    print(id);
    if (id.isNotEmpty) {
      for (var i = 0; i < id.length; i++) {
        selectedid = selectedid + id[i].toString() + ",";
      }
      c = selectedid.split("");
      c.removeLast();
    }
    if (price.isNotEmpty) {
      for (var i = 0; i < price.length; i++) {
        selectedprice = selectedprice + price[i].toString() + ",";
      }
      priceList = selectedprice.split("");
      priceList.removeLast();
    }
    print("Join Price List");
    print(c.join());
    print(priceList.join());
    dynamic data = await APIService.getFilteredProduct(
        filterid(c.join().toString(), priceList.join().toString()));
    print(data);
    if (data != null) {
      setState(() {
        product = FilteredProduct.fromJson(data);
      });
    }
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircularProgressIndicator())
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => product.data.length > 0
            ? CustomScrollView(slivers: <Widget>[
                _buildPopularRestaurant(),
                // _buildPopularRestaurant(),
              ])
            : Center(
                child: Text("No Product Found"),
              ));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          title: Text(
            "Filtered Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _asyncLoader);
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
                          id: product.data[index].productId.toString(),
                        )),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: getProportionateScreenWidth(140),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                id: product.data[index].productId.toString(),
                              )),
                    );
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
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
                              imageUrl: product.data[index].image.toString(),
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
                        Flexible(
                          child: Container(
                            child: Center(
                                child: Text(
                              product.data[index].name.toString(),
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto',
                                color: const Color(0xFF212121),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  // "PKR " +
                                  //     product.data[index].price
                                  //         .toString()
                                  //         .substring(
                                  //             0,
                                  //             product.data[index].price
                                  //                 .toString()
                                  //                 .indexOf('.')),
                                  product.data[index].price.toString() == "null"
                                      ? "PKR " +
                                          product.data[index].price.toString()
                                      : "PKR " +
                                          product.data[index].price
                                              .toString()
                                              .substring(
                                                  0,
                                                  product.data[index].price
                                                      .toString()
                                                      .indexOf('.')),
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
                            if (1 != "null") ...[
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String userID = preferences
                                      .getString("UserID")
                                      .toString();

                                  if (userID == "null") {
                                    Fluttertoast.showToast(
                                        msg: "Please Login First");
                                  } else {
                                    String token = preferences
                                        .getString("loggedIntoken")
                                        .toString();

                                    dynamic data =
                                        await APIService.WishlistItem(
                                            product.data[index].productId
                                                .toString(),
                                            userID,
                                            token);
                                    Fluttertoast.showToast(
                                        msg: data['message'].toString());
                                    setState(() {
                                      getData();
                                    });

                                    // setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(8)),
                                  height: getProportionateScreenWidth(28),
                                  width: getProportionateScreenWidth(28),
                                  decoration: BoxDecoration(
                                    color: true
                                        ? HexColor(
                                                getjson.banner[0].primaryColor)
                                            .withOpacity(0.15)
                                        : kSecondaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: Color(0xFFDBDEE4),
                                  ),
                                ),
                              ),
                            ],
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String userID =
                                    preferences.getString("UserID").toString();

                                if (userID == "null") {
                                  Navigator.pushNamed(
                                      context, SignInScreen.routeName);
                                } else {
                                  AddToCartModel cartModel = new AddToCartModel(
                                      productId: product.data[index].productId
                                          .toString(),
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
                                      ? HexColor(getjson.banner[0].primaryColor)
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
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        }, childCount: product.data.length));
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }
}
