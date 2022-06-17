import 'package:flutter/material.dart';

import 'package:MakkiHerb/constants.dart';

import 'package:MakkiHerb/size_config.dart';

import './shipment_form.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//  getprofiledata(String? data) async{

//   GetDetail data =await GetDetail.getusername();

//   setState(() {

//   //print(data.lastname);
// name = data.name;

//   });
//   }

  //String? name;
  @override
  void initState() {
    super.initState();

//getprofiledata(name);
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
                Text("Shipment Details", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                //ProfilePic(),

                // Text(
                //  '' ,
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(),
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
