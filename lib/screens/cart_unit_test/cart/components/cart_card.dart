import 'package:MakkiHerb/constant/api_services.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/Cart.dart';
import '../../../../models/CartModel.dart';
import '../../../../size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CartCard extends StatefulWidget {
  final Items cart;
  CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  _CartCardState createState() => _CartCardState(this.cart);
}

class _CartCardState extends State<CartCard> {
  final Items cart;
  _CartCardState(this.cart);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                // child: Image.asset(cart.product.images[0]),
                child: CachedNetworkImage(
                  imageUrl: cart.product.images[0].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/Placeholders.png'),
                )),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
            child: Container(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Text(
              "Quantity " + cart.quantity.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(
                text:
                    "\PKR ${cart.product.price.toString().substring(0, cart.product.price.indexOf('.'))}",
                style: TextStyle(fontWeight: FontWeight.w600),
                // children: [
                //   TextSpan(
                //       text: " x${cart.quantity}",
                //       style: Theme.of(context).textTheme.bodyText1),
                // ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  String cartItemID = cart.id.toString();

                  dynamic i = await APIService.moveToWishList(
                      preferences.getString("loggedIntoken").toString(),
                      cartItemID);
                  setState(() {});
                  Fluttertoast.showToast(msg: i['message'].toString());
                },
                child: Container(
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color: Color(0xFFFF4848),
                  ),
                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String id = cart.product.id.toString();

                              preferences =
                                  await SharedPreferences.getInstance();
                              String token = preferences
                                  .getString("loggedIntoken")
                                  .toString();

                              int plusqty = cart.quantity - 1;

                              dynamic data = await APIService.addToCartUpdate(
                                  token, id, plusqty.toString());

                              print("Minus");
                              print(data);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove,
                              size: 24,
                              color: Colors.green.shade600,
                            )),
                        Container(
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.only(
                              bottom: 2, right: 12, left: 12),
                          child: Text(cart.quantity.toString()),
                        ),
                        GestureDetector(
                            child: Icon(
                              Icons.add,
                              size: 26,
                              color: Colors.green.shade600,
                            ),
                            onTap: () async {
                              String id = cart.id.toString();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences =
                                  await SharedPreferences.getInstance();
                              String token = preferences
                                  .getString("loggedIntoken")
                                  .toString();

                              int plusqty = cart.quantity + 1;

                              dynamic data = await APIService.addToCartUpdate(
                                  token, id, plusqty.toString());
                              print("Plus");
                              print(data);
                              setState(() {});
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )))
      ],
    );
  }
}
