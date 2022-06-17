import 'dart:async';
import 'dart:convert';

import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/SavePaymentAsGuest.dart';
import 'package:MakkiHerb/models/saveOrderAsGuest.dart';
import 'package:MakkiHerb/screens/Billing_Recipt/unpaid_page.dart';
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
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/widgetjson.dart';

class UnpaidPageGuest extends StatefulWidget {
  BillingReciptModel.BillingRecipt paymentdata;
  UnpaidPageGuest({Key? key, required this.paymentdata}) : super(key: key);
  @override
  _UnpaidPageGuestState createState() => _UnpaidPageGuestState(paymentdata);
}

class _UnpaidPageGuestState extends State<UnpaidPageGuest> {
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
  late SavePaymentAsGuest savePaymentAsGuest;
  BillingReciptModel.BillingRecipt paymentdata;
  _UnpaidPageGuestState(this.paymentdata);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final data = await APIService.jsonfile();
    getjson = widgetjson.fromJson(data);
    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

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
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.53,
          child: paymentdata.data.cart.items.isNotEmpty
              ? FadeAnimation(
                  1.4,
                  AnimatedList(
                      scrollDirection: Axis.vertical,
                      initialItemCount: paymentdata.data.cart.items.length,
                      itemBuilder: (context, index, animation) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: [
                            MaterialButton(
                              color: Colors.red.withOpacity(0.15),
                              elevation: 0,
                              height: 60,
                              minWidth: 60,
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ],
                          child: cartItem(paymentdata.data.cart.items[index],
                              index, animation),
                        );
                      }),
                )
              : Center(
                  child: Text("Empty"),
                ),
        ),
        SizedBox(height: 30),
        FadeAnimation(
          1.2,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Shipping', style: TextStyle(fontSize: 20)),
                Text(paymentdata.data.cart.formatedTaxTotal.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        FadeAnimation(
            1.3,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Text(paymentdata.data.cart.formatedGrandTotal.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  //'\${totalPrice + 5.99}',
                ],
              ),
            )),
        SizedBox(height: 10),
        FadeAnimation(
            1.4,
            Padding(
              padding: EdgeInsets.all(20.0),
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
                        print("loggedIntoken");
                        print(
                            preferences.getString("loggedIntoken").toString());
                        dynamic data = await APIService.SaveOrder(
                            preferences.getString("loggedIntoken").toString());

                        print("Unpaid Recipti");
                        print(data);
                        SaveOrderAsGuest saveOrder =
                            SaveOrderAsGuest.fromJson(data);

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
                color: HexColor(getjson.banner.isNotEmpty
                    ? getjson.banner[0].primaryColor
                    : kPrimaryColor),
                child: Center(
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
    return new Future.delayed(TIMEOUT, () => {});
  }
}
