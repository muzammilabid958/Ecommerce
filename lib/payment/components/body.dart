import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:MakkiHerb/screens/profile/components/profile_pic.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import './payment_form.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MakkiHerb/models/Billing_Recipt.dart' as BillingReciptModel;
import 'package:MakkiHerb/models/payments.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

    this.recipt = BillingReciptModel.BillingRecipt.fromJson(data);

    setState(() {
      this.recipt = BillingReciptModel.BillingRecipt.fromJson(data);
    });
  }

  @override
  void initState() {
    super.initState();

//getprofiledata(name);
  }

  String _instructions = 'Tap on "Pay" Button to try PayTabs plugin';

  PaymentSdkConfigurationDetails generateConfig() {
    getData();

    var billingDetails = BillingDetails(
        this.recipt.data.cart.customerFirstName +
            " " +
            this.recipt.data.cart.customerLastName,
        this.recipt.data.cart.customerEmail.toString(),
        this.recipt.data.cart.billingAddress.phone.toString(),
        this.recipt.data.cart.billingAddress.address1[0].toString(),
        this.recipt.data.cart.billingAddress.country.toString(),
        // "ae",
        this.recipt.data.cart.billingAddress.city.toString(),
        this.recipt.data.cart.billingAddress.state.toString(),
        this.recipt.data.cart.billingAddress.postcode.toString());
    var shippingDetails = ShippingDetails(
        this.recipt.data.cart.customerFirstName +
            " " +
            this.recipt.data.cart.customerLastName,
        this.recipt.data.cart.customerEmail.toString(),
        this.recipt.data.cart.billingAddress.phone.toString(),
        this.recipt.data.cart.billingAddress.address1[0].toString(),
        this.recipt.data.cart.billingAddress.country.toString(),
        // "ae",
        this.recipt.data.cart.billingAddress.city.toString(),
        this.recipt.data.cart.billingAddress.state.toString(),
        this.recipt.data.cart.billingAddress.postcode.toString());
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount: double.parse(this.recipt.data.cart.grandTotal),
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: "PKR",
        merchantCountryCode: "SA",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = "assets/images/App-Icon-Orange-bg.png";

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> apmsPayPressed() async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig(),
        (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*Profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 20.0,
        currencyCode: "AED",
        merchantCountryCode: "ae",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          applePayPressed();
        },
        child: Text('Pay with Apple Pay'),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: SizedBox(
    //     width: double.infinity,
    //     child: Padding(
    //       padding:
    //           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Text("Payment Details", style: headingStyle),
    //             SizedBox(height: SizeConfig.screenHeight * 0.03),
    //             //ProfilePic(),

    //             Text(
    //               '',
    //               textAlign: TextAlign.center,
    //             ),
    //             SizedBox(height: SizeConfig.screenHeight * 0.03),
    //             CompleteProfileForm(),
    //             SizedBox(height: getProportionateScreenHeight(30)),
    //             Text(
    //               "By continuing your confirm that you agree \nwith our Term and Condition",
    //               textAlign: TextAlign.center,
    //               style: Theme.of(context).textTheme.caption,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text('$_instructions'),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              payPressed();
            },
            child: Text('Pay with Card'),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              apmsPayPressed();
            },
            child: Text('Pay with Alternative payment methods'),
          ),
          SizedBox(height: 16),
          applePayButton()
        ]));
  }
}
