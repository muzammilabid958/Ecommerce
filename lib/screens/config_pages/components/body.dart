import 'dart:convert';
import 'dart:io';

import 'package:MakkiHerb/models/configPage.dart';
import 'package:MakkiHerb/screens/change_password/changepassword_screen.dart';
import 'package:MakkiHerb/screens/complete_profile/components/loader_profile.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/screens/complete_profile/complete_profile_screen.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/orders/orders.dart';
import 'package:MakkiHerb/screens/shipment/shipment_screen.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:MakkiHerb/widget/alert_dialog.dart';

import '../../../models/widgetjson.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  String pagename;
  Body(this.pagename, {Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(this.pagename);
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  int userID = 0;
  String username = "";
  late SharedPreferences preferences;
  String profile = "";

  String pagename;

  _BodyState(this.pagename);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    readJson();
    getConfigPages();
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  ConfigPages configPages = new ConfigPages(data: []);
  getConfigPages() async {
    final data = await APIService.configpagesOnePage(pagename);
    print(data);
    configPages = ConfigPages.fromJson(data);
    setState(() {
      configPages = ConfigPages.fromJson(data);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print("deactivate");
    super.deactivate();
  }

  widgetjson getjson = new widgetjson(banner: []);
  readJson() async {
    // final String response =
    //     await APIService.jsonfile();
    // final data =  json.decode(jsondata);
    // setState(() {
    //   getjson = widgetjson.fromJson(data);
    // });

    final data = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: HexColor(Theme_Settings.loaderColor['color']),
                  )
                ])),
        renderError: ([error]) => Text('Something Went Wrong'),
        renderSuccess: ({data}) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Html(data: configPages.data[0].PageContent),
              ),
            ));
    return _asyncLoader;
  }
}
