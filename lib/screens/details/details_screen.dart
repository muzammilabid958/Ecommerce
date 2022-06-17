import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/ProductDetail.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/details/all-comments.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async_loader/async_loader.dart';
import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';

import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/details/components/product_images.dart';
import 'package:MakkiHerb/screens/details/components/top_rounded_container.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/ProductDetail.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';
import '../../models/AddToCart.dart';
import '../../models/Product.dart';
import '../../size_config.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  String id;
  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(this.id);
}

class _DetailScreenState extends State<DetailScreen> {
  String id;
  _DetailScreenState(this.id);
  ProductDetail detail = ProductDetail(
      data: Data(
          baseImage: BaseImage(
              largeImageUrl: '',
              mediumImageUrl: '',
              originalImageUrl: '',
              smallImageUrl: ''),
          createdAt: '',
          description: '',
          formatedPrice: '',
          images: [],
          id: 0,
          inStock: false,
          isItemInCart: false,
          isSaved: false,
          isWishlisted: false,
          name: '',
          price: '',
          reviews: Reviews(),
          shortDescription: '',
          showQuantityChanger: false,
          sku: '',
          superAttributes: [],
          type: '',
          updatedAt: '',
          urlKey: '',
          variants: [],
          formatedSpecialPrice: '',
          specialPrice: ''));
  List<String> images = [];
  int quantity = 1;
  getProductDetail(String id) async {
    print(id);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    dynamic data = await APIService.ProductDetail(
        preferences.getString("loggedIntoken").toString(), id);
    // dynamic data = await APIService.ProductDetail(
    //     preferences.getString("loggedIntoken").toString(), "259");

    print(data);
    setState(() {
      detail = new ProductDetail.fromJson(data);
    });

    for (var i = 0; i < detail.data.images!.length; i++) {
      images.add(detail.data.images![i].url.toString());
    }
  }

  widgetjson getjson = new widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    print(this.id);
    getProductDetail(this.id);
    readJson();
  }

  Variant? selectedValue;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        // renderLoad: () => const Center(child: CircularProgressIndicator()),
        renderLoad: () => Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            )),
        renderError: ([error]) => Center(
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_1,
                title: 'Detail is not Avaible',
                subTitle: 'No Product Detail',
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            ),
        renderSuccess: ({data}) => ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(350),
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(20)),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),

                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            imageUrl: detail.data.images!.length > 0
                                ? detail.data.images![0].url.toString()
                                : "",
                            placeholder: (context, url) => new Center(
                                child: CircularProgressIndicator(
                              color: HexColor(
                                  getjson.banner[0].primaryColor.toString()),
                            )),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/Placeholders.png',
                            ),
                          ),
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(detail.data.images!.length,
                                (index) => buildSmallProductPreview(index)),
                          ],
                        ))
                  ],
                ),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Text(
                              detail.data.name.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          if (detail.data.specialPrice.toString().isNotEmpty &&
                              detail.data.specialPrice.toString() !=
                                  "null") ...[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(64),
                                  top: getProportionateScreenWidth(10)),
                              child: Text(
                                "PKR ${detail.data.specialPrice.toString().substring(0, detail.data.specialPrice.toString().indexOf('.'))}",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: HexColor(getjson
                                        .banner[0].primaryColor
                                        .toString()),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(64),
                                  top: getProportionateScreenWidth(10)),
                              child: Text(
                                "PKR ${detail.data.specialPrice.toString().substring(0, detail.data.specialPrice.toString().indexOf('.'))}",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  // color: HexColor(getjson.banner[0].primaryColor
                                  //     .toString()),
                                  color: HexColor(kPrimaryColor),
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(64),
                                  top: getProportionateScreenWidth(10)),
                              child: Text(
                                "${detail.data.formatedPrice.toString()}",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'Roboto',
                                  color: HexColor(getjson.banner[0].primaryColor
                                      .toString()),
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(20),
                                right: getProportionateScreenWidth(64),
                                top: getProportionateScreenWidth(20)),
                            child: const Text(
                              "Description",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(20),
                                right: getProportionateScreenWidth(64),
                                top: getProportionateScreenWidth(10),
                                bottom: getProportionateScreenHeight(10)),
                            child: Html(
                                data: detail.data.description
                                    .toString()
                                    .toString()),
                          ),
                          if (detail.data.variants != null) ...[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(64),
                                  top: getProportionateScreenWidth(20)),
                              child: Text(
                                "Variants",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            for (var i = 0;
                                i < this.detail.data.superAttributes!.length;
                                i++) ...[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(64),
                                ),
                                child: Text(
                                  detail.data.superAttributes![i].name
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(20),
                                  right: getProportionateScreenWidth(20),
                                ),
                                child: SearchableDropdown.single(
                                  items: detail
                                      .data.superAttributes![i].options!
                                      .map(
                                    (val) {
                                      return DropdownMenuItem<Variant>(
                                        value: Variant(val.id.toString(),
                                            val.label.toString()),
                                        child: Text(val.label.toString()),
                                      );
                                    },
                                  ).toList(),
                                  style: const TextStyle(
                                    // textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 15,
                                    letterSpacing: 0.1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  value: selectedValue,
                                  hint: const Text("Select one"),
                                  searchHint: "Select one",
                                  onChanged: (Variant value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ]
                          ],
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Container(
                            width: 400,
                            child: SpinBox(
                              value: double.parse(quantity.toString()),
                              min: 1,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 0, 0)),
                              textAlign: TextAlign.center,
                              onChanged: (value) => quantity = value.toInt(),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, all_comments.routeName);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      all_comments(detail.data.id.toString())),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "See All Comments",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor(kPrimaryColor)),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: HexColor(kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TopRoundedContainer(
                        color: const Color(0xFFF6F7F9),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Row(
                                children: const [
                                  Spacer(),
                                ],
                              ),
                            ),
                            TopRoundedContainer(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: DefaultButton(
                                  text: "Add To Cart",
                                  // primaryColor:
                                  //     getjson.banner[0].primaryColor.toString(),
                                  // primaryColor: kPrimaryColor,
                                  press: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String userID = preferences
                                        .getString("UserID")
                                        .toString();

                                    String token = preferences
                                        .getString("loggedIntoken")
                                        .toString();
                                    print(token);
                                    if (userID == "null") {
                                      AddToCartModel cartModel = AddToCartModel(
                                          productId: detail.data.id.toString(),
                                          quantity: "1");
                                      dynamic data = await APIService.AddToCart(
                                          cartModel, "");

                                      Fluttertoast.showToast(
                                          msg: data['message'].toString());
                                    } else {
                                      if (quantity == 0) {
                                        Fluttertoast.showToast(
                                            msg: "Please select Quantity");
                                      } else {
                                        if (selectedValue != null) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  selectedValue!.id.toString());

                                          print("Color ID" +
                                              selectedValue!.colorid
                                                  .toString());
                                          print("Color" +
                                              selectedValue!.color.toString());
                                          print("Size" +
                                              selectedValue!.size.toString());
                                          print("Size ID" +
                                              selectedValue!.id.toString());
                                          // var variant = detail.data.variants!.where(
                                          //     (element) =>
                                          //         element.size == selectedValue!.size &&
                                          //         element.color == selectedValue);

                                          // var variant = detail.data.variants!
                                          //     .where((x) => x.size == selectedValue);
                                          // print("Variant Data");
                                          // print(variant);

                                          // print(json.encode(detail.data.variants!));
                                          // AddToCartModel cartModel = new AddToCartModel(
                                          //     productId: detail
                                          //         .data.variants![defaultChoiceIndex].id
                                          //         .toString(),
                                          //     quantity: quantity.toString());
                                          // dynamic data = await APIService.AddToCart(
                                          //     cartModel,
                                          //     preferences
                                          //         .getString('loggedIntoken')
                                          //         .toString());
                                          // print(data);

                                          // Fluttertoast.showToast(
                                          //     msg: data['message'].toString());
                                        } else {
                                          AddToCartModel cartModel =
                                              AddToCartModel(
                                                  productId:
                                                      detail.data.id.toString(),
                                                  quantity:
                                                      quantity.toString());
                                          dynamic data =
                                              await APIService.AddToCart(
                                                  cartModel,
                                                  preferences
                                                      .getString(
                                                          'loggedIntoken')
                                                      .toString());
                                          print(data);
                                          setState(() {});

                                          Fluttertoast.showToast(
                                              msg: data['message'].toString());
                                        }
                                      }

                                      // if (selectedValue != "") {
                                      //   var selecteddata = detail.data.variants!.where(
                                      //       (element) => element.size == selectedValue);

                                      //   print(selecteddata);
                                      //   // product.
                                      //   AddToCartModel cartModel = new AddToCartModel(
                                      //       productId: selectedValue,
                                      //       quantity: quantity.toString());
                                      //   dynamic data = await APIService.AddToCart(
                                      //       cartModel,
                                      //       preferences
                                      //           .getString('loggedIntoken')
                                      //           .toString());
                                      //   print(data);

                                      //   Fluttertoast.showToast(
                                      //       msg: data['message'].toString());
                                      // } else {}
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        // child: CustomAppBar(),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      // primary: getjson.banner[0].primaryColor.isNotEmpty
                      //     ? HexColor(getjson.banner[0].primaryColor)
                      //     : kPrimaryColor,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      "assets/icons/Back ICon.svg",
                      height: 15,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Text(
                        detail.data.reviews!.total == null
                            ? ""
                            : detail.data.reviews!.total.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/Star Icon.svg"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: _asyncLoader,
    );
  }

  static const TIMEOUT = Duration(seconds: 15);

  getMessage() async {
    return Future.delayed(TIMEOUT, () => {});
  }

  int selectedImage = 0;
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
              color: HexColor(getjson.banner.isNotEmpty
                      ? getjson.banner[0].primaryColor.toString()
                      : kPrimaryColor) //HexColor(getjson.banner[0].primaryColor)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        // child: Image.asset(widget.product.images[index]),

        child: CachedNetworkImage(
          imageUrl: detail.data.images![0].url.toString(),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: HexColor(getjson.banner.isNotEmpty
                      ? getjson.banner[0].primaryColor.toString()
                      : kPrimaryColor))),
          errorWidget: (context, url, error) =>
              Image.asset('assets/images/Placeholders.png'),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
