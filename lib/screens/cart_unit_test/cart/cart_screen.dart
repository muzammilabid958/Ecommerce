import 'dart:async';
import 'dart:convert';

import 'package:MakkiHerb/screens/cart/cart_screen.dart';
import 'package:MakkiHerb/screens/cart_unit_test/cart/components/cart_card.dart';
import 'package:MakkiHerb/screens/shipment/components/bodyshipmentformguest.dart';
import 'package:MakkiHerb/screens/shipment/components/shipment_form_guest.dart';
import 'package:MakkiHerb/screens/shipment/shipment_screen_for_guest.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../../constant/api_services.dart';
import '../../../constant/config.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../models/CartModel.dart';
import '../../../size_config.dart';
import '../../cart/components/couponresponse.dart';
import '../../sign_in/sign_in_screen.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/screens/billing_address/billing_address_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartUnitTesting extends StatefulWidget {
  const CartUnitTesting({Key? key}) : super(key: key);

  @override
  _CartUnitTestingState createState() => _CartUnitTestingState();
}

class _CartUnitTestingState extends State<CartUnitTesting> {
  static String routeName = "/cart";
  Timer? _timer;
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

  TextEditingController _coupontext = new TextEditingController();
  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  getCartData() async {
    preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("loggedIntoken").toString();

    print("Shared Preferences Token");
    print(this.token);
    if (this.token == "null") {
      //   Navigator.pushNamed(context, SignInScreen.routeName);
      print("If COntr");
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String guest = preferences.getString("GuestUserCookies").toString();

      print(guest);
      dynamic data = await APIService.GetCartItemGuest(guest);

      setState(() {
        cartModel = CartModel.fromJson(data);
      });
    } else {
      dynamic data = await APIService.GetCartItem(
          preferences.getString("loggedIntoken").toString());

      setState(() {
        cartModel = CartModel.fromJson(data);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      getCartData();
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
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
              child: cartModel.data.items.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartModel.data.items.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            dynamic removedata =
                                await APIService.RemoveFromCart(
                                    preferences
                                        .getString("loggedIntoken")
                                        .toString(),
                                    cartModel.data.items[index].id.toString());
                            dynamic data = await APIService.GetCartItem(
                                preferences
                                    .getString("loggedIntoken")
                                    .toString());

                            setState(() {
                              getCartData();
                            });
                            setState(() {
                              cartModel.data.items.removeAt(index);
                              setState(() {});
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
                          // child: CartCard(cart: cartModel.data.items[index]),

                          child: Row(
                            children: [
                              SizedBox(
                                width: 88,
                                child: AspectRatio(
                                  aspectRatio: 0.88,
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(10)),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      // child: Image.asset(cart.product.images[0]),
                                      child: CachedNetworkImage(
                                        // imageUrl:
                                        //     cart.product.images[0].url.toString(),
                                        imageUrl: cartModel.data.items[index]
                                            .product.images[0].url
                                            .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/Placeholders.png'),
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
                                    // cart.product.name,
                                    cartModel.data.items[index].name.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Quantity " +
                                        cartModel.data.items[index].quantity
                                            .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: cartModel
                                          .data.items[index].formatedPrice
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String cartItemID = cartModel
                                            .data.items[index].id
                                            .toString();

                                        dynamic i =
                                            await APIService.moveToWishList(
                                                preferences
                                                    .getString("loggedIntoken")
                                                    .toString(),
                                                cartItemID);

                                        Fluttertoast.showToast(
                                            msg: i['message'].toString());
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: SvgPicture.asset(
                                          "assets/icons/Heart Icon_2.svg",
                                          color: Color(0xFFFF4848),
                                        ),
                                      )),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          "",
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              GestureDetector(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String id = cartModel
                                                        .data.items[index].id
                                                        .toString();

                                                    preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String token = preferences
                                                        .getString(
                                                            "loggedIntoken")
                                                        .toString();

                                                    int plusqty = cartModel
                                                            .data
                                                            .items[index]
                                                            .quantity -
                                                        1;

                                                    dynamic data =
                                                        await APIService
                                                            .addToCartUpdate(
                                                                token,
                                                                id,
                                                                plusqty
                                                                    .toString());

                                                    print("Minus");
                                                    Fluttertoast.showToast(
                                                        msg: data['message']);
                                                    setState(() {
                                                      getCartData();
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 24,
                                                    color:
                                                        Colors.green.shade600,
                                                  )),
                                              Container(
                                                color: Colors.grey.shade200,
                                                padding: const EdgeInsets.only(
                                                    bottom: 2,
                                                    right: 12,
                                                    left: 12),
                                                child: Text(cartModel
                                                    .data.items[index].quantity
                                                    .toString()),
                                              ),
                                              GestureDetector(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 26,
                                                    color:
                                                        Colors.green.shade600,
                                                  ),
                                                  onTap: () async {
                                                    String id = cartModel
                                                        .data.items[index].id
                                                        .toString();
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String token = preferences
                                                        .getString(
                                                            "loggedIntoken")
                                                        .toString();

                                                    int plusqty = cartModel
                                                            .data
                                                            .items[index]
                                                            .quantity +
                                                        1;

                                                    dynamic data =
                                                        await APIService
                                                            .addToCartUpdate(
                                                                token,
                                                                id,
                                                                plusqty
                                                                    .toString());
                                                    print("Plus");
                                                    Fluttertoast.showToast(
                                                        msg: data['message']);
                                                    setState(() {
                                                      getCartData();
                                                    });
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
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("Cart is Empty"),
                    ),
            ));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${cartModel.data.items.length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: _asyncLoader,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(10),
          horizontal: getProportionateScreenWidth(20),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/receipt.svg",
                          color: HexColor(kPrimaryColor),
                        ),
                      )),
                  //     Spacer(),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Coupon '),
                                content: TextFormField(
                                  onChanged: (value) {
                                    // setState(() {
                                    //   valueText = value;
                                    // });
                                  },
                                  controller: _coupontext,
                                  decoration: const InputDecoration(
                                      hintText: "Redeem Discount"),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    color: Colors.orange,
                                    textColor: Colors.white,
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();

                                      String _token = pref
                                          .getString("loggedIntoken")
                                          .toString();

                                      Navigator.pop(context);
                                      final msg = json.encode({
                                        'code': _coupontext.text.toString()
                                      });
                                      var res = await http.post(
                                          Uri.parse(Config.baseURL +
                                              Config.couponpost +
                                              '?token=true'),
                                          body: msg,
                                          headers: {
                                            'Content-Type': 'application/json',
                                            'Authorization': 'Bearer $_token',
                                            'Accept': 'application/json',
                                          });

                                      var data = jsonDecode(res.body);

                                      Couponres couponres;
                                      couponres = Couponres?.fromJson(data);

                                      if (!couponres.success) {
                                        Fluttertoast.showToast(
                                            msg: couponres.message.toString());
                                      }
                                      setState(() {
                                        getCartData();
                                      });
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text("Add voucher code")),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          // error occure that why it's implements
                          text: cartModel.data.grandTotal.isNotEmpty
                              ? cartModel.data.formatedGrandTotal.toString()
                              : "PKR 0",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  if (cartModel.data.items.length > 0) ...[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Empty",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          )),
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();

                        String _token =
                            pref.getString("loggedIntoken").toString();
                        dynamic data = await APIService.cartEmpty(_token);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                      color: Colors.red,
                      textColor: Colors.yellow,
                      padding: EdgeInsets.all(14.0),
                      splashColor: Colors.grey,
                    )
                    // SizedBox(
                    //   width: getProportionateScreenWidth(90),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     height: getProportionateScreenHeight(56),
                    //     child: TextButton(
                    //       style: TextButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20)),
                    //         primary: Colors.white,
                    //         backgroundColor: Colors.red,
                    //       ),
                    //       onPressed: () async {
                    //         SharedPreferences pref =
                    //             await SharedPreferences.getInstance();

                    //         String _token =
                    //             pref.getString("loggedIntoken").toString();
                    //         dynamic data = await APIService.cartEmpty(_token);
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => CartScreen()),
                    //         );
                    //       },
                    //       child: Text(
                    //         "Empty",
                    //         style: TextStyle(
                    //           fontSize: getProportionateScreenWidth(18),
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                  SizedBox(
                    width: getProportionateScreenWidth(120),
                    child: DefaultButton(
                        text: "Check Out",
                        press: () async {
                          if (cartModel.data.items.isEmpty) {
                            _timer?.cancel();
                            Fluttertoast.showToast(msg: "Cart is Empty");
                            _timer?.cancel();
                          } else {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();

                            if (preferences
                                    .getString("UserID")
                                    .toString()
                                    .isEmpty ||
                                preferences.getString("UserID").toString() ==
                                    "null") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ShipmentFormGuestUser()));
                            } else {
                              Navigator.pushNamed(
                                  context, billing_address_screen.routeName);
                            }
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
