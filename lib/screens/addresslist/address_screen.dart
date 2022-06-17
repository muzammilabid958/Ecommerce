import 'package:flutter/material.dart';
import 'package:MakkiHerb/screens/addresslist/body.dart';

class AddresslistScreen extends StatefulWidget {
  static String routeName = "/shipping_list";

  @override
  State<AddresslistScreen> createState() => _AddresslistScreenState();
}

class _AddresslistScreenState extends State<AddresslistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: Body(),
    );
  }
}
