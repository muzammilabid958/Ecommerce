import 'dart:async';
import 'dart:math';

import 'package:MakkiHerb/models/profile.dart';
import 'package:MakkiHerb/screens/complete_profile/complete_profile_screen.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/serverError.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/api_services.dart';
import '../../../models/FeatureProduct.dart';
import '../../../models/HomeSlider.dart';
import '../../../models/Productss.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../../models/profile.dart' as ProfileData;
import 'package:hexcolor/hexcolor.dart';

class loading_profile extends StatefulWidget {
  static String routeName = "/loaderprofile";
  @override
  State<loading_profile> createState() => _loading_profileState();
}

class _loading_profileState extends State<loading_profile> {
  getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.customerProfile(token);

    ProfileData.ProfileData profileData =
        ProfileData.ProfileData.fromJson(data);

    print("profiling");
    print(profileData.data.id);

    profileData.data.id != 0
        ? Timer(const Duration(seconds: 5), () async {
            print("if wali condition ");

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString("profile_id", profileData.data.id.toString());
            preferences.setString(
                "profile_email", profileData.data.email.toString());
            preferences.setString(
                "profile_firstname", profileData.data.firstName.toString());
            preferences.setString(
                "profile_lastname", profileData.data.firstName.toString());
            preferences.setString(
                "profile_phone", profileData.data.phone.toString());
            preferences.setString(
                "profile_dob", profileData.data.dateOfBirth.toString());
            preferences.setString(
                "profile_gender", profileData.data.gender.toString());
            //   Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteProfileScreen()));
          })
        : print("hello");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    // _scrollController = ScrollController();

    // getFeaturedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AwesomeLoader(
      loaderType: AwesomeLoader.AwesomeLoader3,
      color: HexColor(Theme_Settings.loaderColor['color']),
    )

            // ): Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => loading_page()))
            ));
  }
}
