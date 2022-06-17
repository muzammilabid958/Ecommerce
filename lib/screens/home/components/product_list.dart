// import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/HomeSlider.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/category/sliderProduct.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:MakkiHerb/models/Productss.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:awesome_loader/awesome_loader.dart';
import '../../category/product_category_screen.dart';
import 'package:async_loader/async_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductList extends StatefulWidget {
  List<Productss> products;

  static const TIMEOUT = const Duration(seconds: 10);

  ProductList({required this.products});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final SwiperController swiperController = SwiperController();

  List<Productss> products = [];
  _ProductListState();
  getMessage() async {
    final String response = await APIService.jsonfile();
    final data = await json.decode(response);
    getjson = widgetjson.fromJson(data);
    return Future.delayed(ProductList.TIMEOUT, () => {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  HomeSlider slider_Data = HomeSlider(
      data: [],
      links: Links(first: '', last: ''),
      meta: Meta(
          currentPage: 0,
          from: 0,
          lastPage: 0,
          link: [],
          path: '',
          perPage: 0,
          to: 0,
          total: 0));
  widgetjson getjson = widgetjson(banner: []);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;

    return FutureBuilder<dynamic>(
        future: APIService.HomePageSlider(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            ));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              HomeSlider slider_Data = HomeSlider.fromJson(snapshot.data);

              return SizedBox(
                height: cardHeight,
                child: Swiper(
                  itemCount: slider_Data.data.length,
                  itemWidth: 40,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: () {
                          print(slider_Data.data[index].slider_is);
                          if (slider_Data.data[index].slider_is.toString() ==
                              'is_flashsale') {
                            print("0");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SliderProduct(
                                        id: slider_Data
                                            .data[index].slider_product
                                            .toString(),
                                      )),
                            );
                          }
                          if (slider_Data.data[index].slider_is.toString() ==
                              'is_category') {
                            print("1");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryAllProduct(
                                      id: slider_Data.data[index].slider_product
                                          .toString())),
                            );
                          }
                          if (slider_Data.data[index].slider_is.toString() ==
                              'slider_product') {
                            // Fluttertoast.showToast(
                            //     msg: "Product ID" + this.product.slider_product.toString());
                          }
                          if (slider_Data.data[index].slider_is.toString() ==
                              'is_product') {
                            // Fluttertoast.showToast(msg: this.product.slider_product.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        id: slider_Data
                                            .data[index].slider_product
                                            .toString(),
                                      )),
                            );
                          }
                        },
                        child: InkWell(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 30),
                                height: cardHeight,
                                width: cardWidth,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                  // color: Color(0xffE99E22),
                                  gradient: LinearGradient(
                                    colors: <HexColor>[
                                      HexColor(getjson.banner.isNotEmpty
                                          ? getjson.banner[0]
                                              .LinearGradientSliderColor
                                          : kPrimaryColor),
                                      HexColor(getjson.banner.isNotEmpty
                                          ? getjson.banner[0]
                                              .LinearGradientSliderColor
                                          : kPrimaryColor),
                                      HexColor(getjson.banner.isNotEmpty
                                          ? getjson.banner[0]
                                              .LinearGradientSliderColor
                                          : kPrimaryColor),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {},
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                slider_Data.data[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 12.0),
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 4.0, 12.0, 4.0),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Hero(
                                    tag: "product",
                                    // child: Image.asset(
                                    //   "assets/images/headphones_2.png",
                                    //   height: height / 1.7,
                                    //   width: width / 1.4,
                                    //   fit: BoxFit.contain,
                                    // ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            slider_Data.data[index].imageUrl,
                                        height: cardHeight / 1.2,
                                        width: cardWidth / 1.0,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.green[800],
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/Placeholders.png',
                                          height: 300,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ));
                  },
                  scale: 0.8,
                  controller: swiperController,
                  viewportFraction: 0.6,
                  loop: true,
                  autoplayDelay: 4000,
                  fade: 0.5,
                  autoplay: true,
                  duration: 300,
                  pagination: SwiperCustomPagination(
                    builder: (context, config) {
                      if (products.length > 20) {
                        print(
                            "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
                      }
                      Color activeColor = Colors.red;
                      Color color = Colors.grey.withOpacity(.3);
                      double size = 10.0;
                      double space = 4.0;

                      if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                          config.layout == SwiperLayout.DEFAULT) {
                        return PageIndicator(
                          count: products.length,
                          controller: config.pageController!,
                          layout: config.indicatorLayout,
                          size: size,
                          activeColor: activeColor,
                          color: color,
                          space: space,
                        );
                      }

                      List<Widget> dots = [];

                      int itemCount = config.itemCount;
                      int activeIndex = config.activeIndex;

                      for (int i = 0; i < itemCount; ++i) {
                        bool active = i == activeIndex;
                        dots.add(Container(
                          key: Key("pagination_$i"),
                          margin: EdgeInsets.all(space),
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: active ? activeColor : color,
                              ),
                              width: size,
                              height: size,
                            ),
                          ),
                        ));
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: dots,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }
        });
  }
}

class ProductCard extends StatefulWidget {
  final Data product;
  final double height;
  final double width;

  final widgetjson getjson;
  const ProductCard(
      {required this.product,
      required this.height,
      required this.width,
      required this.getjson});

  @override
  _ProductCardState createState() => _ProductCardState(
      product: product, height: height, width: width, getjson: getjson);
}

class _ProductCardState extends State<ProductCard> {
  final Data product;
  final double height;
  final double width;
  _ProductCardState({
    required this.product,
    required this.height,
    required this.width,
    required this.getjson,
  });

  @override
  void initState() {
    readJson();
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final String response = await APIService.jsonfile();
    final data = await json.decode(response);
    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(this.product.slider_is);
          if (this.product.slider_is.toString() == 'is_flashsale') {
            print("0");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SliderProduct(
                        id: this.product.slider_product.toString(),
                      )),
            );
          }
          if (this.product.slider_is.toString() == 'is_category') {
            print("1");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryAllProduct(
                      id: this.product.slider_product.toString())),
            );
          }
          if (this.product.slider_is.toString() == 'slider_product') {
            // Fluttertoast.showToast(
            //     msg: "Product ID" + this.product.slider_product.toString());
          }
          if (this.product.slider_is.toString() == 'is_product') {
            // Fluttertoast.showToast(msg: this.product.slider_product.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        id: this.product.slider_product.toString(),
                      )),
            );
          }
        },
        child: InkWell(
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  // color: Color(0xffE99E22),
                  gradient: LinearGradient(
                    colors: <HexColor>[
                      HexColor(getjson.banner[0].LinearGradientSliderColor),
                      HexColor(getjson.banner[0].LinearGradientSliderColor),
                      HexColor(getjson.banner[0].LinearGradientSliderColor),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                child: Hero(
                    tag: "product",
                    // child: Image.asset(
                    //   "assets/images/headphones_2.png",
                    //   height: height / 1.7,
                    //   width: width / 1.4,
                    //   fit: BoxFit.contain,
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        height: height / 1.2,
                        width: width / 1.0,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: Colors.green[800],
                        )),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/Placeholders.png',
                          height: 300,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
