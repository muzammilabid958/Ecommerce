import 'dart:async';

import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';

import '../../../constant/api_services.dart';
import '../../../models/FeatureProduct.dart';
import '../../../models/HomeSlider.dart';
import '../../../models/Productss.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class loading_page extends StatefulWidget {
  static String routeName = "/loaderscreen";
  @override
  State<loading_page> createState() => _loading_pageState();
}

class _loading_pageState extends State<loading_page> {
  late HomeSlider slider_Data;
  late FeatureProduct product;
  //new FeatureProduct(data: []);
  List<Productss> products = [];
  getFeaturedProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();
    dynamic data = await APIService.FeatureProductListing(token, "?featured=1");
    product = FeatureProduct.fromJson(data);
    //  print(“yallah”);
    print(product.data.length);
    // setState(() {
    // }
    // );
  }

  getProduct() async {
    products.clear();
    print(products);
    dynamic data = await APIService.HomePageSlider();
    //print(“anas”);
    slider_Data = HomeSlider.fromJson(data);
    print(slider_Data.data.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (1 == 1) {
      Timer(const Duration(seconds: 5), () {
        getProduct();
// getFeaturedProduct();
        //
        // slider_Data.data.isEmpty ?
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        //      :print(“HATH HOGAYA”);
      });
    } else {}
    // getFeaturedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AwesomeLoader(
      loaderType: AwesomeLoader.AwesomeLoader3,
      color: HexColor(Theme_Settings.loaderColor['color']),
    )

        // ): Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => loading_page()))
        );
  }
}
