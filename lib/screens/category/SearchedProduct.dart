import 'dart:convert';

import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
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
import 'package:MakkiHerb/models/searchProduct.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../models/widgetjson.dart';
import 'package:empty_widget/empty_widget.dart';

class SearchedProduct extends StatefulWidget {
  String query;

  SearchedProduct({Key? key, required this.query}) : super(key: key);

  @override
  _SearchedProductState createState() => _SearchedProductState(this.query);
}

class _SearchedProductState extends State<SearchedProduct> {
  String query;

  SearchProduct product = new SearchProduct(data: []);

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  _SearchedProductState(this.query);
  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  searchProduct(String query) async {
    dynamic data = await APIService.searchProduct(query);
    print(data);
    product = new SearchProduct.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    // Fluttertoast.showToast(msg: query);

    searchProduct(query);
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

  double _lowerValue = 50;
  double _upperValue = 180;
  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => Center(
          child: AwesomeLoader(
        loaderType: AwesomeLoader.AwesomeLoader3,
        color: HexColor(Theme_Settings.loaderColor['color']),
      )),
      renderError: ([error]) => Text('Something Went Wrong'),
      renderSuccess: ({data}) => product.data.length > 0
          ? CustomScrollView(slivers: <Widget>[
              _buildPopularRestaurant(),
              // _buildPopularRestaurant(),
            ])
          : Center(
              child: Column(children: [
                EmptyWidget(
                  image: null,
                  packageImage: PackageImage.Image_1,
                  title: 'Seaching Product',
                  subTitle: 'No  Product Available yet',
                  titleTextStyle: TextStyle(
                    fontSize: 22,
                    color: Color(0xff9da9c7),
                    fontWeight: FontWeight.w500,
                  ),
                  subtitleTextStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffabb8d6),
                  ),
                )
              ]),
            ),
    );
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            "Search for " + this.query,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _asyncLoader);
  }

  SliverGrid _buildPopularRestaurant() {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          // return Text(product.data[0].name.toString());
          return product.data.length > 0
              ? GestureDetector(
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
                                      id: product.data[index].productId
                                          .toString(),
                                    )),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(20)),
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
                                    imageUrl: product.data[index].images_url
                                            .toString()
                                            .isNotEmpty
                                        ? product.data[index].images_url
                                            .toString()
                                        : "",
                                    placeholder: (context, url) => new Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.green[800],
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/placeholder.png')),
                                // ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  product.data[index].name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black),
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
                                      "PKR " +
                                          product.data[index].price
                                              .toString()
                                              .substring(
                                                  0,
                                                  product.data[index].price
                                                      .toString()
                                                      .indexOf('.')),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String userID = preferences
                                        .getString("UserID")
                                        .toString();

                                    if (userID == "null") {
                                      Navigator.pushNamed(
                                          context, SignInScreen.routeName);
                                    } else {
                                      AddToCartModel cartModel =
                                          new AddToCartModel(
                                              productId: product
                                                  .data[index].productId
                                                  .toString(),
                                              quantity: "1");
                                      dynamic data = await APIService.AddToCart(
                                          cartModel,
                                          preferences
                                              .getString('loggedIntoken')
                                              .toString());
                                      print(data);

                                      // CartModel cartResponseModel =
                                      //     CartModel.fromJson(json.decode(data));

                                      Fluttertoast.showToast(
                                          msg: data['message'].toString());
                                      setState(() {});
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
                                                  ? getjson
                                                      .banner[0].primaryColor
                                                  : kPrimaryColor)
                                              .withOpacity(0.15)
                                          : kSecondaryColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        Theme_Settings.HomeHeaderCartIcon),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              : Center(
                  child: EmptyWidget(
                    image: null,
                    packageImage: PackageImage.Image_1,
                    title: 'Seaching Product',
                    subTitle: 'No  Product Available yet',
                    titleTextStyle: TextStyle(
                      fontSize: 22,
                      color: Color(0xff9da9c7),
                      fontWeight: FontWeight.w500,
                    ),
                    subtitleTextStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xffabb8d6),
                    ),
                  ),
                );
        }, childCount: product.data.length));
  }
}

class Filtre extends StatefulWidget {
  @override
  _FiltreState createState() => _FiltreState();
}

class _FiltreState extends State<Filtre> {
  double _lowerValue = 60;
  double _upperValue = 1000;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Reset"),
              Text("Filters"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          SingleChildScrollView(
            child: Row(
              children: <Widget>[
                buildChip("American", Colors.grey.shade400, "A",
                    Colors.grey.shade600),
                buildChip("Turkish", Theme.of(context).primaryColor, "A",
                    Theme.of(context).primaryColor),
                buildChip(
                    "Asia", Colors.grey.shade400, "A", Colors.grey.shade600),
                buildChip(
                    "Europe", Colors.grey.shade400, "A", Colors.grey.shade600),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              buildChip(
                  "Lorem", Colors.grey.shade400, "A", Colors.grey.shade600),
              buildChip(
                  "Ipsum", Colors.grey.shade400, "A", Colors.grey.shade600),
              buildChip(
                  "Dolır", Colors.grey.shade400, "A", Colors.grey.shade600),
              buildChip(
                  "Sit amed", Colors.grey.shade400, "A", Colors.grey.shade600),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("SORT BY"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Rated",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Nearest Me"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cost Hight to Low"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cost Low to Hight"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
            child: Text("PRICE"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("\$ " + '$_lowerValue'),
                Text("\$ " + '$_upperValue'),
              ],
            ),
          ),
          FlutterSlider(
            tooltip: FlutterSliderTooltip(
              leftPrefix: Icon(
                Icons.attach_money,
                size: 19,
                color: Colors.black45,
              ),
              rightSuffix: Icon(
                Icons.attach_money,
                size: 19,
                color: Colors.black45,
              ),
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
                border: Border.all(width: 3, color: Colors.blue),
              ),
              activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red.withOpacity(0.5)),
            ),
            values: [30, 420],
            rangeSlider: true,
            max: 500,
            min: 0,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              _lowerValue = lowerValue;
              _upperValue = upperValue;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Padding buildChip(
      String label, Color color, String avatarTitle, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 2.0, left: 2.0),
      child: FilterChip(
        padding: EdgeInsets.all(4.0),
        label: Text(
          label,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(color: color),
        ),
        onSelected: (bool value) {
          print("selected");
        },
      ),
    );
  }
}
