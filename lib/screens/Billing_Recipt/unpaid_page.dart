import 'dart:async';
import 'dart:convert';

import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';

import 'package:MakkiHerb/models/Billing_Recipt.dart' as BillingReciptModel;
import 'package:MakkiHerb/models/SaveOrder.dart';
import 'package:MakkiHerb/models/payments.dart';
import 'package:MakkiHerb/screens/order_success/order_success_screen.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:simple_animations/simple_animations.dart';
import '../../models/widgetjson.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UnpaidPage extends StatefulWidget {
  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage> {
  late SharedPreferences prefs;
  bool enableDisable = true;
  BillingReciptModel.BillingRecipt recipt = BillingReciptModel.BillingRecipt(
      data: BillingReciptModel.Data(
          cart: BillingReciptModel.Cart(
              id: 0,
              customerEmail: "",
              customerFirstName: "",
              customerLastName: "",
              shippingMethod: "",
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
              selectedShippingRate: BillingReciptModel.SelectedShippingRate(
                  id: 0,
                  carrier: "",
                  carrierTitle: "",
                  method: "",
                  methodTitle: "",
                  methodDescription: "",
                  price: 0,
                  formatedPrice: "",
                  basePrice: 0,
                  formatedBasePrice: "",
                  createdAt: "",
                  updatedAt: ""),
              payment: BillingReciptModel.Payment(
                  id: 0,
                  method: "",
                  methodTitle: "",
                  createdAt: "",
                  updatedAt: ""),
              billingAddress: BillingReciptModel.BillingAddress(
                  id: 0,
                  firstName: "",
                  lastName: "",
                  name: "",
                  email: "",
                  address1: [],
                  country: "",
                  countryName: "",
                  state: "",
                  city: "",
                  postcode: "",
                  phone: "",
                  createdAt: "",
                  updatedAt: ""),
              shippingAddress: BillingReciptModel.ShippingAddress(
                  id: 0,
                  firstName: "",
                  lastName: "",
                  name: "",
                  email: "",
                  address1: [],
                  country: "",
                  countryName: "",
                  state: "",
                  city: "",
                  postcode: "",
                  phone: "",
                  createdAt: "",
                  updatedAt: ""),
              createdAt: "",
              updatedAt: "",
              taxes: "",
              formatedTaxes: "",
              baseTaxes: "",
              formatedBaseTaxes: "",
              formatedDiscountedSubTotal: "",
              formatedBaseDiscountedSubTotal: ""),
          message: ""));
  getData() async {
    prefs = await SharedPreferences.getInstance();
    Payments paymentMethod =
        Payments(payment: Paymentsss(method: 'cashondelivery'));
    dynamic data = await APIService.SavePayment(
        prefs.getString("loggedIntoken").toString(), paymentMethod);

    this.recipt = BillingReciptModel.BillingRecipt.fromJson(data);

    setState(() {
      this.recipt = BillingReciptModel.BillingRecipt.fromJson(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getData();
    });
    readJson();
  }

  final StreamController<BillingReciptModel.BillingRecipt> _streamController =
      StreamController();
  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  bool onPressedValue = true;
  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            )
          ])),
      renderError: ([error]) => const Text('Something Went Wrong'),
      renderSuccess: ({data}) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.53,
          child: recipt.data.cart.items.isNotEmpty
              ? FadeAnimation(
                  1.4,
                  AnimatedList(
                      scrollDirection: Axis.vertical,
                      initialItemCount: recipt.data.cart.items.length,
                      itemBuilder: (context, index, animation) {
                        return Slidable(
                          actionPane: const SlidableDrawerActionPane(),
                          secondaryActions: [
                            MaterialButton(
                              color: Colors.red.withOpacity(0.15),
                              elevation: 0,
                              height: 60,
                              minWidth: 60,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ],
                          child: cartItem(
                              recipt.data.cart.items[index], index, animation),
                        );
                      }),
                )
              : Container(),
        ),
        const SizedBox(height: 30),
        FadeAnimation(
          1.2,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Shipping', style: const TextStyle(fontSize: 20)),
                Text(recipt.data.cart.formatedTaxTotal.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        FadeAnimation(
            1.3,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  Text(recipt.data.cart.formatedGrandTotal.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
        const SizedBox(height: 10),
        FadeAnimation(
            1.4,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: onPressedValue == true
                    ? () async {
                        setState(() {
                          onPressedValue = false;
                        });
                        Timer(const Duration(seconds: 30), () {
                          setState(() {
                            onPressedValue = true;
                          });
                        });
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        dynamic data = await APIService.SaveOrder(
                            preferences.getString("loggedIntoken").toString());

                        print("Unpaid Recipti");
                        print(data);
                        SaveOrder saveOrder = SaveOrder.fromJson(data);

                        if (saveOrder.success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderSuccessScreen(
                                      orderno: saveOrder.order.id.toString(),
                                    )),
                          );
                        }
                      }
                    : null,
                height: 50,
                elevation: 0,
                splashColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: getjson.banner.isNotEmpty
                    ? getjson.banner.isNotEmpty
                        ? HexColor(getjson.banner[0].primaryColor)
                        : HexColor(kPrimaryColor)
                    : HexColor(kPrimaryColor),
                child: const Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ))
      ]),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Confirm Order",
          ),
        ),
        body: _asyncLoader);
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return Future.delayed(TIMEOUT, () => {});
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          const Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: (animation as Map)["opacity"],
        child: Transform.translate(
            offset: Offset(0, (animation as Map)["translateY"]), child: child),
      ),
    );
  }
}

cartItem(BillingReciptModel.Items product, int index, animation) {
  return GestureDetector(
    onTap: () {},
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(animation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.product.images[0].url,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.formatedPrice,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Text(
                    "x " + product.quantity.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    ),
  );
}
