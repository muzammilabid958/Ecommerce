import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/Product.dart';
import 'package:html/dom.dart' as dom;
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_spinbox/material.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  late Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.title.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                String userID = preferences.getString("UserID").toString();
                String token =
                    preferences.getString("loggedIntoken").toString();

                if (userID == "null") {
                  Fluttertoast.showToast(msg: "Please Login First");
                } else {
                  String token =
                      preferences.getString("loggedIntoken").toString();

                  dynamic data = await APIService.WishlistItem(
                      product.id.toString(), userID, token);

                  Fluttertoast.showToast(msg: data['message'].toString());
                }
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: product.isFavourite!
                      ? Color(0xFFFFE6E6)
                      : Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: product.isFavourite!
                      ? Color(0xFFFF4848)
                      : Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "PKR ${product.price.toString()}",
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
