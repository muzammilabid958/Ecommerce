import 'dart:convert';

import 'package:MakkiHerb/screens/login_success/login_success_screen.dart';
import 'package:MakkiHerb/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/Response.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../sign_in/sign_in_screen.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
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
    if (pref.getString("registerEmail").toString().isNotEmpty) {
      Email = pref.getString("registerEmail");
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
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
                maxLength: 1,
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
                maxLength: 1,
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
                maxLength: 1,
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
                maxLength: 1,
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

            final response =
                await http.post(Uri.parse(Config.baseURL + Config.validateotp),
                    body: ({
                      'email': Email,
                      'otp': otp,
                    }));

            final responseJson = json.decode(response.body);

            Response responseModel = Response.fromJson(responseJson);
            print(responseModel.message);
            if (responseModel.message == "Success") {
              SharedPreferences pref = await SharedPreferences.getInstance();
              // Email = pref.getString("registerEmail");

              pref.remove('registerEmail');
              Navigator.pushNamed(context, SignInScreen.routeName);
            } else {
              Fluttertoast.showToast(msg: responseModel.message.toString());
            }
          },
        )
      ],
    );
  }
}
