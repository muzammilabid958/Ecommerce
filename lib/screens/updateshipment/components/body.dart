import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';

import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/FetchAddress.dart';

import 'package:MakkiHerb/size_config.dart';

import 'update_shipment_form.dart';

class Body extends StatefulWidget {
  String id;
  Body(this.id);

  @override
  State<Body> createState() => _BodyState(this.id);
}

class _BodyState extends State<Body> {
  String id;

  _BodyState(this.id);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Edit Shipment Details", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                //ProfilePic(),

                // Text(
                //  '' ,
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                EditShipmentForm(this.id),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
