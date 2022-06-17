import 'package:flutter/material.dart';

import 'components/body.dart';

class EditShipmentScreen extends StatefulWidget {
  static String routeName = "/shipment";

  String id;

  EditShipmentScreen({required this.id});

  @override
  State<EditShipmentScreen> createState() => _EditShipmentScreenState(this.id);
}

class _EditShipmentScreenState extends State<EditShipmentScreen> {
  String id;

  _EditShipmentScreenState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: Body(this.id),
    );
  }
}
