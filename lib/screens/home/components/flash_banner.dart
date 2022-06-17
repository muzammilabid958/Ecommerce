import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/HomeSlider.dart';
import 'package:MakkiHerb/models/Productss.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../../settings/settings.dart';
import '../../category/product_category_screen.dart';
import '../../category/sliderProduct.dart';
import '../../details/details_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlashSaleBanner extends StatefulWidget {
  const FlashSaleBanner({Key? key}) : super(key: key);

  @override
  _FlashSaleBannerState createState() => _FlashSaleBannerState();
}

class _FlashSaleBannerState extends State<FlashSaleBanner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late HomeSlider slider_Data;

  @override
  Widget build(BuildContext context) {
    Widget child;

    return FutureBuilder<dynamic>(
        future: APIService.flashHomePageSlider(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            ));
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              HomeSlider slider_Data = HomeSlider.fromJson(snapshot.data);
              return GestureDetector(
                  onTap: () {},
                  child: CachedNetworkImage(
                    imageUrl: slider_Data.data[0].imageUrl.toString(),
                    height: 200,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                        child: AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader3,
                      color: HexColor(Theme_Settings.loaderColor['color']),
                    )),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/Placeholders.png',
                      fit: BoxFit.cover,
                    ),
                  ));
            }
          }
        });
  }
}
