import 'dart:convert';

import 'package:MakkiHerb/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/config.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutCard extends StatelessWidget {
  String total;
  TextEditingController _coupontext = TextEditingController();
  CheckoutCard({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
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
                      child: SvgPicture.asset("assets/icons/receipt.svg"),
                    )),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Coupon '),
                              content: TextFormField(
                                onChanged: (value) {
                                  // setState(() {
                                  //   valueText = value;
                                  // });
                                },
                                controller: _coupontext,
                                decoration: InputDecoration(
                                    hintText: "Insert your coupon code"),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  child: Text('OK'),
                                  onPressed: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();

                                    String _token = pref
                                        .getString("loggedIntoken")
                                        .toString();
                                    print(_token);
                                    final msg = json.encode(
                                        {'code': _coupontext.text.toString()});
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
                                    print(data);
                                    // Couponres couponres;
                                    // couponres = Couponres?.fromJson(data);

                                    // print(couponres.success.toString());

                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text("Add voucher code")),
                const SizedBox(width: 10),
                Icon(
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
                        text: "PKR " +
                            total
                                .substring(0, total.toString().indexOf('.'))
                                .toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
