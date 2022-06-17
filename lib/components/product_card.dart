import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/FeatureProduct.dart';
import 'package:MakkiHerb/models/Product.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';

import '../constants.dart';
import 'package:hexcolor/hexcolor.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      this.width = 140,
      this.aspectRetio = 1.02,
      // this.product,
      required this.productname,
      required this.productid,
      required this.productimage,
      required this.productprice,
      required this.isFavorite})
      : super(key: key);

  final double width, aspectRetio;
  // final Data? product;

  final String productname, productid, productimage, productprice;
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: productid.toString(),

                    // child: Image.asset(product!.images![0].toString()),
                    child: Image.network(
                      productimage.toString(),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                productname.toString(),
                style: TextStyle(color: Colors.black),
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PKR${productprice}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: HexColor(kPrimaryColor),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String userID =
                          preferences.getString("UserID").toString();

                      String token =
                          preferences.getString("loggedIntoken").toString();

                      dynamic data = await APIService.WishlistItem(
                          productid.toString(), userID, token);
                      print("dsds");
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: isFavorite
                            ? HexColor(kPrimaryColor).withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color:
                            isFavorite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
