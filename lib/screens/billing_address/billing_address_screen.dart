import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'components/body.dart';

class billing_address_screen extends StatefulWidget {
  static String routeName = "/billing";

  @override
  State<billing_address_screen> createState() => _billing_address_screenState();
}

class _billing_address_screenState extends State<billing_address_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Billing Address',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_location_alt,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/shipment');
              // do something
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}
