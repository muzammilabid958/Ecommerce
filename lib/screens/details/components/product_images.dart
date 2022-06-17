import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MakkiHerb/models/Product.dart';

import '../../../constant/api_services.dart';
import '../../../constants.dart';
import '../../../models/widgetjson.dart';
import '../../../size_config.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductImages extends StatefulWidget {
  ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  Product product = new Product(
      id: 0,
      images: [],
      colors: [],
      isFavourite: false,
      title: "",
      price: 0.0,
      description: "");

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  void initState() {
    readJson();
  }

  widgetjson getjson = new widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();
    final data = await json.decode(jsondata);
    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              // child: Image.asset(widget.product.images[selectedImage]),
              child: CachedNetworkImage(
                imageUrl: widget.product.images[selectedImage].toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: HexColor(getjson.banner[0].primaryColor.toString()),
                )),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/Placeholders.png'),
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(widget.product.images.length,
                    (index) => buildSmallProductPreview(index)),
              ],
            ))
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: HexColor(getjson.banner[0].primaryColor
                      .toString()) //HexColor(getjson.banner[0].primaryColor)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        // child: Image.asset(widget.product.images[index]),

        child: CachedNetworkImage(
          imageUrl: widget.product.images[index].toString(),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: HexColor(getjson.banner[0].primaryColor.toString()))),
          errorWidget: (context, url, error) =>
              Image.asset('assets/images/Placeholders.png'),
        ),
      ),
    );
  }
}
