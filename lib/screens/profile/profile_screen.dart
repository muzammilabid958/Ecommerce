import 'package:flutter/material.dart';
import 'package:MakkiHerb/components/coustom_bottom_nav_bar.dart';
import 'package:MakkiHerb/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
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
            title: Text("Profile"),
          ),
          body: Body(),
          bottomNavigationBar:
              CustomBottomNavBar(selectedMenu: MenuState.profile),
        ));
  }
}
