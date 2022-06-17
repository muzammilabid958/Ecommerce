import 'dart:convert';

import 'package:MakkiHerb/models/ProductDetail.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/rounded_icon_btn.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/AddToCart.dart';
import 'package:MakkiHerb/models/Product.dart';
import 'package:MakkiHerb/size_config.dart';

import '../../../models/widgetjson.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  final Product product;
  final ProductDetail detail;
  const Body({Key? key, required this.product, required this.detail})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState(this.product, this.detail);
}

class _BodyState extends State<Body> {
  Product product;
  ProductDetail detail;
  List<FilterChipData> filterChips = FilterChips.all;
  int defaultChoiceIndex = 0;
  String _dropDownValue = "";
  bool isselected = false;
  Variant? selectedValue;
  _BodyState(this.product, this.detail);

  int quantity = 1;

  int _value = 1;

  final List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: Text("wordPair"),
      value: "ds",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
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

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
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
                      product.title.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  if (product.specialPrice.toString().isNotEmpty &&
                      product.specialPrice.toString() != "null") ...[
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20),
                          right: getProportionateScreenWidth(64),
                          top: getProportionateScreenWidth(10)),
                      child: Text(
                        "PKR ${product.price.toString().substring(0, product.price.toString().indexOf('.'))}",
                        style: new TextStyle(
                            fontSize: 25.0,
                            color: HexColor(
                                getjson.banner[0].primaryColor.toString()),
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
                        "PKR ${product.specialPrice.toString().substring(0, product.specialPrice.toString().indexOf('.'))}",
                        style: new TextStyle(
                          fontSize: 25.0,
                          color: HexColor(
                              getjson.banner[0].primaryColor.toString()),
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
                        "PKR ${product.price.toString()}",
                        style: new TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Roboto',
                          color: HexColor(
                              getjson.banner[0].primaryColor.toString()),
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
                    child: Text(
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
                    child: Html(data: product.description.toString()),
                  ),
                  if (this.detail.data.variants != null) ...[
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
                    SizedBox(
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
                          this.detail.data.superAttributes![i].name.toString(),
                          style: TextStyle(
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
                          items:
                              this.detail.data.superAttributes![i].options!.map(
                            (val) {
                              return DropdownMenuItem<Variant>(
                                value: Variant(
                                    val.id.toString(), val.label.toString()),
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
                          hint: Text("Select one"),
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
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Container(
                    width: 400,
                    child: SpinBox(
                      value: double.parse(quantity.toString()),
                      min: 1,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: 'Quantity',
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      textAlign: TextAlign.center,
                      onChanged: (value) => quantity = value.toInt(),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "See More Detail",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: HexColor(
                                  getjson.banner[0].primaryColor.toString()),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: HexColor(
                                getjson.banner[0].primaryColor.toString()),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
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
                          primaryColor:
                              getjson.banner[0].primaryColor.toString(),
                          press: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            String userID =
                                preferences.getString("UserID").toString();

                            String token = preferences
                                .getString("loggedIntoken")
                                .toString();
                            print(token);
                            if (userID == "null") {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            } else {
                              if (quantity == 0) {
                                Fluttertoast.showToast(
                                    msg: "Please select Quantity");
                              } else {
                                if (selectedValue != null) {
                                  Fluttertoast.showToast(
                                      msg: selectedValue!.id.toString());

                                  print("Color ID" +
                                      selectedValue!.colorid.toString());
                                  print("Color" +
                                      selectedValue!.color.toString());
                                  print(
                                      "Size" + selectedValue!.size.toString());
                                  print(
                                      "Size ID" + selectedValue!.id.toString());
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
                                  AddToCartModel cartModel = new AddToCartModel(
                                      productId: product.id.toString(),
                                      quantity: quantity.toString());
                                  dynamic data = await APIService.AddToCart(
                                      cartModel,
                                      preferences
                                          .getString('loggedIntoken')
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
    );
  }
}

class FilterChipDatas {
  final String? label;
  final String? value;
  final Color? color;
  final bool isSelected;

  const FilterChipDatas({
    this.label,
    this.color,
    this.value,
    this.isSelected = false,
  });

  FilterChipData copy({
    String? label,
    Color? color,
    String? value,
    bool? isSelected,
  }) =>
      FilterChipData(
        label: label ?? this.label,
        color: color ?? this.color,
        value: value ?? this.value,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          color == other.color &&
          value == other.value &&
          isSelected == other.isSelected;

  @override
  int get hashCode => label.hashCode ^ color.hashCode ^ isSelected.hashCode;
}

class FilterChips {
  static final all = <FilterChipData>[];
}

class FilterChipData {
  final String? label;
  final String? value;
  final Color? color;
  final bool isSelected;

  const FilterChipData({
    this.label,
    this.color,
    this.value,
    this.isSelected = false,
  });

  FilterChipData copy({
    String? label,
    Color? color,
    String? value,
    bool? isSelected,
  }) =>
      FilterChipData(
        label: label ?? this.label,
        color: color ?? this.color,
        value: value ?? this.value,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          color == other.color &&
          value == other.value &&
          isSelected == other.isSelected;

  @override
  int get hashCode => label.hashCode ^ color.hashCode ^ isSelected.hashCode;
}

class Variant {
  String? size;
  String? id;
  String? color;
  String? colorid;
  Variant(this.id, this.size);
}
