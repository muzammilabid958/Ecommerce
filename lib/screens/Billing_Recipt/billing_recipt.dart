import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/Billing_Recipt.dart' as BillingReciptModel;
import 'package:MakkiHerb/models/payments.dart';

class BillingRecipt extends StatefulWidget {
  const BillingRecipt({Key? key}) : super(key: key);

  @override
  _BillingReciptState createState() => _BillingReciptState();
}

class _BillingReciptState extends State<BillingRecipt> {
  late SharedPreferences prefs;
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
        new Payments(payment: new Paymentsss(method: 'cashondelivery'));
    dynamic data = await APIService.SavePayment(
        prefs.getString("loggedIntoken").toString(), paymentMethod);

    setState(() {
      this.recipt = BillingReciptModel.BillingRecipt.fromJson(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipt",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text("data" + recipt.data.message)],
        ),
      ),
    );
  }
}
