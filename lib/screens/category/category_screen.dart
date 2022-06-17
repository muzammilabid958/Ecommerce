import 'dart:convert';

import 'package:MakkiHerb/components/coustom_bottom_nav_bar.dart';
import 'package:MakkiHerb/enums.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/Categories.dart';
import 'package:MakkiHerb/screens/category/product_category_screen.dart';
import 'package:MakkiHerb/screens/home/components/special_offers.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:awesome_loader/awesome_loader.dart';

import '../../settings/settings.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category";
  CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    super.initState();
    getCategoryData();
    readJson();
  }

  getCategoryData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.CategoryList(token);

    categories = Categories.fromJson(data);
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 15);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

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
                  AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: HexColor(Theme_Settings.loaderColor['color']),
                  )
                ])),
        renderError: ([error]) => Text('Something Went Wrong'),
        renderSuccess: ({data}) => categories.data.length > 0
            ? ListView.builder(
                reverse: true,
                itemCount: categories.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      padding: EdgeInsets.fromLTRB(10, 16, 10, 10),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryAllProduct(
                                      id: categories.data[index].id
                                          .toString())),
                            );
                          },
                          child: SizedBox(
                            width: getProportionateScreenWidth(242),
                            height: getProportionateScreenWidth(160),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Center(
                                      child: CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    imageUrl: categories.data[index].imageUrl
                                        .toString(),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Placeholders.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )),
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
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: categories.data[index].name,
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      18),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
                })
            : Center(
                child: Text("No Category Found"),
              ));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category",
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.category),
      body: _asyncLoader,
    );
  }
}
