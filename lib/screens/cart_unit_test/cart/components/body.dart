import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/screens/cart/components/check_out_card.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/Cart.dart';
import '../../../../models/CartModel.dart';
import '../../../../size_config.dart';
import 'cart_card.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CartModel cartModel = CartModel(
      // message: "",
      data: Data(
          id: 0,
          customerEmail: "",
          customerFirstName: "",
          customerLastName: "",
          isGift: 0,
          itemsCount: 0,
          itemsQty: "",
          globalCurrencyCode: "",
          baseCurrencyCode: "",
          channelCurrencyCode: "",
          cartCurrencyCode: "",
          grandTotal: "",
          formatedGrandTotal: "",
          baseGrandTotal: "",
          formatedBaseGrandTotal: "",
          subTotal: "",
          formatedSubTotal: "",
          baseSubTotal: "",
          formatedBaseSubTotal: "",
          taxTotal: "",
          formatedTaxTotal: "",
          baseTaxTotal: "",
          formatedBaseTaxTotal: "",
          discount: "",
          formatedDiscount: "",
          baseDiscount: "",
          formatedBaseDiscount: "",
          isGuest: 0,
          isActive: 0,
          items: [],
          createdAt: "",
          updatedAt: "",
          taxes: "",
          formatedTaxes: "",
          baseTaxes: "",
          formatedBaseTaxes: "",
          formatedDiscountedSubTotal: "",
          formatedBaseDiscountedSubTotal: ""));
  static const TIMEOUT = Duration(seconds: 10);
  late SharedPreferences preferences;
  String token = "";

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  getCartData() async {
    preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.GetCartItem(
        preferences.getString("loggedIntoken").toString());

    setState(() {
      cartModel = CartModel.fromJson(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            )),
        renderError: ([error]) => Text('Something Went Wrong'),
        renderSuccess: ({data}) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: cartModel.data.items.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    // key: Key(demoCarts[index].product.id.toString()),
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      dynamic removedata = await APIService.RemoveFromCart(
                          preferences.getString("loggedIntoken").toString(),
                          cartModel.data.items[index].id.toString());
                      dynamic data = await APIService.GetCartItem(
                          preferences.getString("loggedIntoken").toString());

                      // Fluttertoast.showToast(
                      //     msg: removedata['message'].toString());
                      setState(() {
                        getCartData();
                      });
                      setState(() {
                        cartModel.data.items.removeAt(index);
                        setState(() {});
                        // if (cartModel.data.items.length > 0) {
                        //   CheckoutCard(
                        //     total: cartModel.data.grandTotal.toString(),
                        //   );
                        // } else {
                        //   CheckoutCard(
                        //     total: "0",
                        //   );
                        // }
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: cartModel.data.items[index]),
                  ),
                ),
              ),
            ));
    return _asyncLoader;
  }
}
