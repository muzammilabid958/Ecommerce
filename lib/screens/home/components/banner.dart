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

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<dynamic> list = [2];
  List<Productss> carosuel = [];

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  static const TIMEOUT = const Duration(seconds: 10);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: APIService
          .CarsouelHomePageSlider(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // AsyncSnapshot<Your object type>
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
            for (var i = 0; i < slider_Data.data.length; i++) {
              carosuel.add(Productss(
                  slider_Data.data[i].imageUrl.toString(),
                  slider_Data.data[i].title.toString(),
                  slider_Data.data[i].content.toString(),
                  0.0,
                  slider_Data.data[i].id.toString(),
                  slider_Data.data[i].slider_product,
                  slider_Data.data[i].slider_is));

              list.add(slider_Data.data[i].imageUrl.toString());
            }

            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: slider_Data.data
                  .map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        if (item.slider_is.toString() ==
                                            'is_flashsale') {
                                          print("0");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SliderProduct(
                                                      id: item.slider_product
                                                          .toString(),
                                                    )),
                                          );
                                        }
                                        if (item.slider_is.toString() ==
                                            'is_category') {
                                          print("1");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryAllProduct(
                                                        id: item.slider_product
                                                            .toString())),
                                          );
                                        }
                                        if (item.slider_is.toString() ==
                                            'slider_product') {
                                          // Fluttertoast.showToast(
                                          //     msg: "Product ID" +
                                          //         item.slider_product.toString());
                                        }
                                        if (item.slider_is.toString() ==
                                            'is_product') {
                                          // Fluttertoast.showToast(msg: this.product.slider_product.toString());
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      id: item.slider_product
                                                          .toString(),
                                                    )),
                                          );
                                        }
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: item.imageUrl.toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                            child: AwesomeLoader(
                                          loaderType:
                                              AwesomeLoader.AwesomeLoader3,
                                          color: HexColor(Theme_Settings
                                              .loaderColor['color']),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/Placeholders.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            );
          }
        }
      },
    );
  }
}
