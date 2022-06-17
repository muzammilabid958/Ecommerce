import 'package:MakkiHerb/constant/api_services.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/components/coustom_bottom_nav_bar.dart';
import 'package:MakkiHerb/enums.dart';

import '../../models/widgetjson.dart';
import 'components/body.dart';
import 'package:MakkiHerb/models/configPage.dart';

class ConfigPagesView extends StatefulWidget {
  static String routeName = "/profile";
  String pagename;
  String pagetile;
  ConfigPagesView({Key? key, required this.pagename, required this.pagetile})
      : super(key: key);

  @override
  _ConfigPagesViewState createState() =>
      _ConfigPagesViewState(this.pagename, this.pagetile);
}

class _ConfigPagesViewState extends State<ConfigPagesView> {
  static String routeName = "/profile";

  widgetjson getjson = new widgetjson(banner: []);
  String pagename;
  String pagetile;
  _ConfigPagesViewState(this.pagename, this.pagetile);
  readJson() async {
    final data = await APIService.jsonfile();
    getjson = widgetjson.fromJson(data);
    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  @override
  void initState() {
    super.initState();

    readJson();
  }

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
            title: Text(pagetile),
          ),
          body: Body(this.pagename),
          bottomNavigationBar:
              CustomBottomNavBar(selectedMenu: MenuState.profile),
        ));
  }
}
