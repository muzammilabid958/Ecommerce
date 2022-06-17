import 'package:MakkiHerb/screens/Billing_Recipt/unpaid_page_guest.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_alertdialog/material_alertdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/PaymentReturnModel.dart';
import 'package:MakkiHerb/models/payments.dart';
import 'package:MakkiHerb/payment/payment_screen.dart';
import 'package:MakkiHerb/screens/Billing_Recipt/billing_recipt.dart';
import 'package:MakkiHerb/screens/Billing_Recipt/unpaid_page.dart';

import 'package:MakkiHerb/models/Billing_Recipt.dart' as BillingReciptModel;

class PaymentForGuest extends StatefulWidget {
  dynamic paymentdata;
  PaymentForGuest({Key? key, this.paymentdata}) : super(key: key);

  @override
  _PaymentForGuestState createState() =>
      _PaymentForGuestState(this.paymentdata);
}

class _PaymentForGuestState extends State<PaymentForGuest> {
  late SharedPreferences prefs;
  dynamic paymentdata;
  _PaymentForGuestState(this.paymentdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment Method",
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () async {
                          // prefs = await SharedPreferences.getInstance();
                          // prefs.setString("PaymentForGuest", "Card");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => PaymentScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.credit_card),
                          title: Text("Card"),
                          subtitle: Text("Debit / Credit Card"),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        Payments PaymentForGuest = Payments(
                            payment: Paymentsss(method: 'cashondelivery'));
                        dynamic data =
                            await APIService.SavePayment("", PaymentForGuest);
                        print("payment data guest");
                        print(data);

                        BillingReciptModel.BillingRecipt recipt =
                            new BillingReciptModel.BillingRecipt.fromJson(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    UnpaidPageGuest(paymentdata: recipt)));
                      },
                      child: ListTile(
                        leading: Icon(Icons.clean_hands_outlined),
                        title: Text("Cash "),
                        subtitle: Text("Cash On Delivery"),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
