import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          Navigator.of(context).pushNamed('/home');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Sign In"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          body: Body(),
        ));
  }
}
