import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/Categories.dart';
import 'package:MakkiHerb/screens/category/product_category_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'categories.dart' as CategorWidget;

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOfferCard extends StatelessWidget {
  SpecialOfferCard({
    Key? key,
    required this.category,
    required this.id,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image, id;
  final int numOfBrands;
  final GestureTapCallback press;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => new Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircularProgressIndicator())
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => new Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryAllProduct(id: id),
                      ));
                },
                child: SizedBox(
                  width: getProportionateScreenWidth(242),
                  height: getProportionateScreenWidth(100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // child: Column(children: [
                    //   Container(
                    //     child: Text("ewe"),
                    //   )
                    // ]),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          imageUrl: image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/Placeholders.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF343434).withOpacity(0.4),
                                Color(0xFF343434).withOpacity(0.15),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15.0),
                            vertical: getProportionateScreenWidth(10),
                          ),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "$category\n",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "Explore")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
    return _asyncLoader;
  }
}

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  late Categories categories = new Categories(
      data: [],
      meta: new Meta(
          currentPage: 0,
          from: 0,
          lastPage: 0,
          link: [],
          path: "",
          perPage: 0,
          to: 0,
          total: 0),
      links: new Links(first: "", last: ""));
  @override
  void initState() {
    // TODO: implement initState

    getCategoryData();
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  getCategoryData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.CategoryList(token);

    categories = Categories.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => new Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircularProgressIndicator())
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => new Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SectionTitle(
                    title: "Category",
                    press: () {},
                  ),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < categories.data.length; i++) ...[
                        SpecialOfferCard(
                            id: categories.data[i].id.toString(),
                            category: categories.data[i].name,
                            image:
                                categories.data[i].categoryIconPath.toString(),
                            numOfBrands: 2,
                            press: () {})
                      ],
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  ),
                ),
              ],
            ));
    return _asyncLoader;
  }
}
