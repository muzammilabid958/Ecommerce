import 'package:MakkiHerb/screens/shipment/components/shipment_form_guest.dart';
import 'package:flutter/material.dart';

import 'package:MakkiHerb/constants.dart';

import 'package:MakkiHerb/size_config.dart';

import './shipment_form.dart';

class ShipmentFormGuestBody extends StatefulWidget {
  @override
  State<ShipmentFormGuestBody> createState() => _ShipmentFormGuestBodyState();
}

class _ShipmentFormGuestBodyState extends State<ShipmentFormGuestBody> {
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
                Text("Shipment Details", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                ShipmentFormGuest(),
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
