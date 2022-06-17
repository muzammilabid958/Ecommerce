import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Banner.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../size_config.dart';
import './../../../settings/settings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({Key? key}) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  widgetjson getjson = new widgetjson(banner: []);
  Bannertext bannertext = Bannertext(data: Data(mainText: '', subText: ''));
  readJson() async {
    final String response = await APIService.jsonfile();
    final data = await json.decode(response);
    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  @override
  void initState() {
    readJson();

    getDiscountBanner();
  }

  getDiscountBanner() async {
    dynamic data = await APIService.bannertext();
    setState(() {
      bannertext = Bannertext.fromJson(data);
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderStates =
      new GlobalKey<AsyncLoaderState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: APIService.bannertext(),
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
              return Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(getProportionateScreenWidth(15)),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenWidth(10),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      HexColor(getjson.banner.isNotEmpty
                          ? getjson.banner[0].CashBackColor
                          : kPrimaryColor),
                      HexColor(getjson.banner.isNotEmpty
                          ? getjson.banner[0].CashBackColor
                          : kPrimaryColor),
                      HexColor(getjson.banner.isNotEmpty
                          ? getjson.banner[0].CashBackColor
                          : kPrimaryColor),
                    ],
                  ),

                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    textBaseline: TextBaseline.alphabetic,
                    textDirection: TextDirection.ltr,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: TextStyle(color: Theme_Settings.colorWhite),
                          children: [
                            TextSpan(
                                text: bannertext.data.mainText.toString(),
                                style: Theme_Settings.A_Summer_Surpise_Style),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(color: Theme_Settings.colorWhite),
                          children: [
                            TextSpan(
                                text: bannertext.data.subText.toString(),
                                style: Theme_Settings.CashbackStyle),
                          ],
                        ),
                      )
                    ]),
              );
            }
          }
        });
  }
}
