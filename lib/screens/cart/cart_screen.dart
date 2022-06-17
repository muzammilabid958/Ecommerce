import 'dart:async';
import 'dart:convert';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:awesome_loader/awesome_loader.dart';

import 'package:MakkiHerb/components/default_button.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Cart.dart';
import 'package:MakkiHerb/models/CartModel.dart';
import 'package:MakkiHerb/models/UpdateCart.dart' as UpdateCart;
import 'package:MakkiHerb/screens/billing_address/billing_address_screen.dart';
import '../../size_config.dart';
import 'components/check_out_card.dart';
import 'package:http/http.dart' as http;
import 'components/couponresponse.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _coupontext = new TextEditingController();
  static String routeName = "/cart";
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = Duration(seconds: 10);
  late SharedPreferences preferences;
  String token = "";
  Timer? _timer;
  late double _progress;
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
  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  getCartData() async {
    preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("loggedIntoken").toString();

    if (this.token == "null") {
      Fluttertoast.showToast(msg: "Please Login");
    } else {
      dynamic data = await APIService.GetCartItem(
          preferences.getString("loggedIntoken").toString());
      print(data);
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: AwesomeLoader(
                        loaderType: AwesomeLoader.AwesomeLoader3,
                        color: HexColor(Theme_Settings.loaderColor['color']),
                      ))
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: cartModel.data.items.length > 0
                  ? ListView.builder(
                      itemCount: cartModel.data.items.length > 0
                          ? cartModel.data.items.length
                          : 0,
                      itemBuilder: (context, index) {
                        String qty =
                            cartModel.data.items[index].quantity.toString();
                        return Padding(
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
                                      cartModel.data.items[index].id
                                          .toString());
                              dynamic data = await APIService.GetCartItem(
                                  preferences
                                      .getString("loggedIntoken")
                                      .toString());

                              // Fluttertoast.showToast(
                              //     msg: removedata['message'].toString());
                              setState(() {
                                getCartData();
                              });
                              setState(() {
                                cartModel.data.items.removeAt(index);
                                setState(() {});
                                if (cartModel.data.items.length > 0) {
                                  CheckoutCard(
                                    total: cartModel.data.grandTotal.toString(),
                                  );
                                } else {
                                  CheckoutCard(
                                    total: "0",
                                  );
                                }
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
                                      child: CachedNetworkImage(
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
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 13.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                Flexible(
                                                    child: Text(
                                                  cartModel
                                                      .data.items[index].name
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                              ])),
                                          Text(
                                            "Quantity " + qty,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Price " +
                                                cartModel
                                                    .data.items[index].price
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        cartModel.data
                                                            .items[index].price
                                                            .toString()
                                                            .indexOf('.')),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                String cartItemID = cartModel
                                                    .data.items[index].id
                                                    .toString();

                                                dynamic i = await APIService
                                                    .moveToWishList(
                                                        token, cartItemID);

                                                // Fluttertoast.showToast(
                                                //     msg: i['message']
                                                //         .toString());
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "",
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                          onTap: () async {
                                                            String id =
                                                                cartModel
                                                                    .data
                                                                    .items[
                                                                        index]
                                                                    .id
                                                                    .toString();

                                                            preferences =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String token =
                                                                preferences
                                                                    .getString(
                                                                        "loggedIntoken")
                                                                    .toString();

                                                            int plusqty = cartModel
                                                                    .data
                                                                    .items[
                                                                        index]
                                                                    .quantity -
                                                                1;

                                                            dynamic data =
                                                                await APIService
                                                                    .addToCartUpdate(
                                                                        token,
                                                                        id,
                                                                        plusqty
                                                                            .toString());

                                                            setState(() {
                                                              getCartData();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 24,
                                                            color: Colors
                                                                .green.shade600,
                                                          )),
                                                      Container(
                                                        color: Colors
                                                            .grey.shade200,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 2,
                                                                right: 12,
                                                                left: 12),
                                                        child: Text(cartModel
                                                            .data
                                                            .items[index]
                                                            .quantity
                                                            .toString()),
                                                      ),
                                                      GestureDetector(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 26,
                                                            color: Colors
                                                                .green.shade600,
                                                          ),
                                                          onTap: () async {
                                                            String id =
                                                                cartModel
                                                                    .data
                                                                    .items[
                                                                        index]
                                                                    .id
                                                                    .toString();

                                                            preferences =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String token =
                                                                preferences
                                                                    .getString(
                                                                        "loggedIntoken")
                                                                    .toString();

                                                            int plusqty = cartModel
                                                                    .data
                                                                    .items[
                                                                        index]
                                                                    .quantity +
                                                                1;

                                                            dynamic data =
                                                                await APIService
                                                                    .addToCartUpdate(
                                                                        token,
                                                                        id,
                                                                        plusqty
                                                                            .toString());

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
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text("Empty"),
                    ),
            ));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        // Text(
        //   "${cartModel.data.items.length} items",
        //   style: Theme.of(context).textTheme.caption,
        // ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
      ),
      body: _asyncLoader,
      // bottomNavigationBar: CheckoutCard(
      //   total: cartModel.data.grandTotal.toString(),
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
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
                  Spacer(),
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
                                    color: Colors.green,
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
                              ? "PKR " +
                                  cartModel.data.grandTotal.substring(
                                      0, cartModel.data.grandTotal.indexOf('.'))
                              : "PKR 0",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  if (cartModel.data.items.length > 0) ...[
                    SizedBox(
                      width: getProportionateScreenWidth(90),
                      child: SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();

                            String _token =
                                pref.getString("loggedIntoken").toString();
                            dynamic data = await APIService.cartEmpty(_token);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()),
                            );
                          },
                          child: Text(
                            "Empty",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  SizedBox(
                    width: getProportionateScreenWidth(120),
                    child: DefaultButton(
                      text: "Check Out",
                      press: cartModel.data.items.length > 0
                          ? () {
                              Navigator.pushNamed(
                                  context, billing_address_screen.routeName);
                            }
                          : () {
                              _timer?.cancel();
                              EasyLoading.showInfo("Cart is Empty");
                              _timer?.cancel();

                              // Fluttertoast.showToast(msg: "Cart is Empty");
                            },
                    ),
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
