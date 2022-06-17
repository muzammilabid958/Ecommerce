import 'dart:async';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/profile.dart' as ProfileData;

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String username = "";
  String profile = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      getProfile();
    });
  }

  ProfileData.ProfileData profileData = ProfileData.ProfileData(
      data: ProfileData.Data(
          id: 0,
          email: "",
          firstName: "",
          lastName: "",
          name: "",
          gender: "",
          dateOfBirth: "",
          phone: "",
          profile: "",
          emailVerified: 0,
          status: 0,
          createdAt: "",
          updatedAt: ""));

  getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.customerProfile(token);
    setState(() {
      profileData = ProfileData.ProfileData.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CachedNetworkImage(
            imageUrl: profileData.data.profile.toString(),
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/istockphoto-1300845620-612x612.jpeg"),
            ),
          ),
        ],
      ),
    );
  }
}
