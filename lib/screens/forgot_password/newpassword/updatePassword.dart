import 'package:flutter/material.dart';

import 'components/body.dart';

class UpdatePassword extends StatelessWidget {
  static String routeName = "/updatePassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: Body(),
    );
  }
}
