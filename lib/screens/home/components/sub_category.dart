import 'dart:async';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/DescendantCategory.dart';
import 'package:MakkiHerb/screens/_partial/_sub_category_card.dart';
import 'package:MakkiHerb/screens/home/components/section_title.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:MakkiHerb/stuffs/sub_category.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../../size_config.dart';
import 'package:hexcolor/hexcolor.dart';

class SubCategories extends StatefulWidget {
  static String routeName = "/category";

  SubCatId? id;
  DescendantCategory subcat;
  SubCategories({Key? key, this.id, required this.subcat}) : super(key: key);

  @override
  _SubCategoriesState createState() => _SubCategoriesState(id, subcat);
}

class _SubCategoriesState extends State<SubCategories> {
  late DescendantCategory categoryeee = DescendantCategory(data: []);

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);

  // _SubCategoriesState();
  SubCatId? cateid;
  DescendantCategory subcat;
  _SubCategoriesState(this.cateid, this.subcat);

  getMessage() async {
    return Future.delayed(TIMEOUT, () => {});
  }

  @override
  void initState() {
    // TODO: implement initState

    getCategoryData(cateid!.catID.toString());
  }

  getCategoryData(String? id) async {
    dynamic data = await APIService.SubCategories(id);

    categoryeee = DescendantCategory.fromJson(data);
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
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: AwesomeLoader(
                        loaderType: AwesomeLoader.AwesomeLoader3,
                        color: HexColor(Theme_Settings.loaderColor['color']),
                      ))
                ])),
        renderError: ([error]) => const Text('Something Went Wrong'),
        renderSuccess: ({data}) => Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(20)),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (categoryeee.data.length > 0) ...[
                          for (var i = 0; i < categoryeee.data.length; i++) ...[
                            CategoryCard(
                              icon: categoryeee.data[i].categoryIconPath
                                  .toString(),
                              text: categoryeee.data[i].name,
                              id: categoryeee.data[i].id.toString(),
                            ),
                          ],
                        ] else ...[
                          const Center(child: Text("No Sub Category Found"))
                        ],
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    )),
              ],
            ));
    return _asyncLoader;
  }
}
