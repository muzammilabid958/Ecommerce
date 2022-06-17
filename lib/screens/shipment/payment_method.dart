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

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  late SharedPreferences prefs;

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
                          prefs = await SharedPreferences.getInstance();
                          prefs.setString("PaymentMethod", "Card");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PaymentScreen()));
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
                        prefs = await SharedPreferences.getInstance();
                        prefs.setString("PaymentMethod", "Cash");

                        Payments paymentMethod = new Payments(
                            payment: new Paymentsss(method: 'cashondelivery'));
                        dynamic data = await APIService.SavePayment(
                            prefs.getString("loggedIntoken").toString(),
                            paymentMethod);

                        Fluttertoast.showToast(
                            msg: data['data']['message'].toString());

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => UnpaidPage()));
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
