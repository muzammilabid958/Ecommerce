import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/forgetPasswordOTP.dart';
import 'package:MakkiHerb/screens/forgot_password/newpassword/updatePassword.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/Response.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class ForgetPasswordOtpFormScreen extends StatefulWidget {
  const ForgetPasswordOtpFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ForgetPasswordOtpFormScreenState createState() =>
      _ForgetPasswordOtpFormScreenState();
}

class _ForgetPasswordOtpFormScreenState
    extends State<ForgetPasswordOtpFormScreen> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController otpController1 = new TextEditingController();
  TextEditingController otpController2 = new TextEditingController();
  TextEditingController otpController3 = new TextEditingController();
  TextEditingController otpController4 = new TextEditingController();

  String? Email = "";
  String otp = "";
  getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Email = pref.getString("registerEmail");
    print(Email);
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                controller: otpController1,
                autofocus: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin2FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                controller: otpController2,
                focusNode: pin2FocusNode,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) => nextField(value, pin3FocusNode),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                controller: otpController3,
                focusNode: pin3FocusNode,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) => nextField(value, pin4FocusNode),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                controller: otpController4,
                focusNode: pin4FocusNode,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  if (value.length == 1) {
                    pin4FocusNode!.unfocus();
                    // Then you need to check is the code is correct or not
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.15),
        DefaultButton(
          text: "Continue",
          press: () async {
            String otp = otpController1.text.toString() +
                otpController2.text.toString() +
                otpController3.text.toString() +
                otpController4.text.toString();
            SharedPreferences preference =
                await SharedPreferences.getInstance();
            String email =
                preference.getString("ResetPasswordEmail").toString();

            dynamic data = await APIService.VerifyOTP(email, otp);
            print(data);

            if (data['status'] == 200) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => UpdatePassword()));
            } else {
              Fluttertoast.showToast(msg: data['message'].toString());
            }
          },
        )
      ],
    );
  }
}
