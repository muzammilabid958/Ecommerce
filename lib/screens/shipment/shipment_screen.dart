import 'package:flutter/material.dart';

import 'components/body.dart';

class ShipmentScreen extends StatefulWidget {
  static String routeName = "/shipment";

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/shipping_list');
              },
              icon: Icon(Icons.list)),
        ],
      ),
      body: Body(),
    );
  }
}
