import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/api_services.dart';

import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/FetchAddress.dart';
import 'package:MakkiHerb/models/SaveAddress.dart';
import 'package:MakkiHerb/screens/shipment/shipment_screen.dart';
import 'package:MakkiHerb/screens/shipment/shipping_list.dart';

import 'package:MakkiHerb/size_config.dart';

import '../../../models/widgetjson.dart';
import './../billing_address_screen.dart';
import 'package:async_loader/async_loader.dart';
import './shipment_form.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FetchAddress address = new FetchAddress(data: []);
  List<Data> city = [];
  @override
  void initState() {
    super.initState();
    getAddress();
    readJson();
  }

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController? _scrollController;
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {},
          ),
        ),
      );
    });
  }

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.getAddress(token);

    setState(() {
      address = new FetchAddress.fromJson(data);
      city = address.data;
    });
  }

  bool _select1 = false;
  bool _select2 = false;
  bool _select3 = false;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = Duration(seconds: 5);
  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  late widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
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
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => address.data.isEmpty
            ? Center(
                child: Container(
                    width: 200,
                    child: DefaultButton(
                      press: () {
                        Navigator.of(context).pushNamed('/shipment');
                      },
                      text: "Add Address",
                    )))
            : ListView.builder(
                itemCount: address.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () async {},
                      child: Container(
                          padding: EdgeInsets.all(15),
                          // height: 200,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 13,
                              child: ClipPath(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  textBaseline: TextBaseline.alphabetic,
                                  textDirection: TextDirection.ltr,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      child: Text(
                                        address.data[index].city.toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Text(
                                        address.data[index].address1[0]
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
                                      child: Text(
                                        address.data[index].phone.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(15),
                                        width: 100,
                                        height: 40,
                                        child: RaisedButton(
                                          child: Text(
                                            "Select",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          color: HexColor(
                                              getjson.banner[0].primaryColor),
                                          onPressed: () async {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            String token = preferences
                                                .getString("loggedIntoken")
                                                .toString();
                                            SaveAddresss addresss = SaveAddresss(
                                                billing: Billing(
                                                    address1: Address1(
                                                        addressBilling: address
                                                            .data[index]
                                                            .address1
                                                            .toString()),
                                                    useForShipping: "true",
                                                    firstName: preferences
                                                        .getString("name")
                                                        .toString(),
                                                    lastName: preferences
                                                        .getString("last_name")
                                                        .toString(),
                                                    email: preferences
                                                        .getString("email")
                                                        .toString(),
                                                    addressId:
                                                        address.data[index].id),
                                                shipping: Shipping(
                                                    address1: Address1(
                                                        addressBilling: address
                                                            .data[index]
                                                            .address1
                                                            .toString()),
                                                    firstName: preferences
                                                        .getString("name")
                                                        .toString(),
                                                    lastName: preferences
                                                        .getString("last_name")
                                                        .toString(),
                                                    email: preferences.getString("email").toString(),
                                                    addressId: address.data[index].id));
                                            dynamic data =
                                                await APIService.SaveAddress(
                                                    token, addresss);
                                            // ignore: avoid_print
                                            print("Save Address New Working");
                                            // ignore: avoid_print
                                            print(data);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ShippingList()),
                                            );
                                          },
                                        ))
                                  ],
                                ),
                              ))));
                }));
    // return _asyncLoader;

    return _asyncLoader;
  }

  Widget buildTextContentOfContainer(
      String title, String subtitle, TextTheme textStyles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: textStyles.headline5,
        ),
        Text(
          subtitle,
          style: textStyles.bodyText1,
        ),
      ],
    );
  }

  Widget buildDemoContent3(String address) {
    return Column(
      children: <Widget>[
        Container(
            width: 500,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  // backgroundImage: Icon(Icons.home),
                  radius: 25.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                    child: Text(
                  address,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.blue.shade700),
                )),
              ],
            ))
      ],
    );
  }
}
