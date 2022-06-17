import 'package:flutter/material.dart';

import 'components/body.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Body(),
    );
  }
}
