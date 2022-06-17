import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/components/coustom_bottom_nav_bar.dart';
import 'package:MakkiHerb/enums.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'components/body.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  final GlobalKey<AsyncLoaderState> _asyncLoaderStates =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
