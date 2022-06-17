import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/complete_profile";

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          Navigator.of(context).pushNamed('/profile');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Body(),
        ));
  }
}
