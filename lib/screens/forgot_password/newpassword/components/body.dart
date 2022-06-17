import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/LoggedInUser.dart';
import 'package:MakkiHerb/screens/login_success/login_success_screen.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MakkiHerb/components/no_account_text.dart';
import 'package:MakkiHerb/components/socal_card.dart';
import '../../../../size_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'newpassword.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Update Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Update Your Password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                newpassword(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
