import 'dart:math';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/resendOTP.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'otp_form.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              // Text("We sent your code to +1 898 860 ***"),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () async {
                  // OTP code resend
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String email = pref.getString("registerEmail").toString();
                  ResendOTP otp = ResendOTP(email: email);
                  dynamic data = await APIService.resendOTP(otp);
                  Fluttertoast.showToast(msg: data['message']);
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: HexColor(kPrimaryColor)),
          ),
        ),
      ],
    );
  }
}
