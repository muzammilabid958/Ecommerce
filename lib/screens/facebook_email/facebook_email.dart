import 'package:flutter/material.dart';

import 'components/body.dart';

class FacebookEmailScreen extends StatelessWidget {
  static String routeName = "/facebookemail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Email"),
      ),
      body: Body(),
    );
  }
}
