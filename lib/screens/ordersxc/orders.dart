import 'dart:convert';

import 'package:MakkiHerb/settings/settings.dart';
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Orders.dart';
import 'package:MakkiHerb/models/SaveAddress.dart';
import 'package:MakkiHerb/screens/orders/orderdetail.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  static String routeName = "/order";
  late Orders order = new Orders(
      data: [],
      links: new Links(first: '', last: ''),
      meta: new Meta(
          currentPage: 0,
          from: 0,
          lastPage: 0,
          link: [],
          path: "",
          perPage: 0,
          to: 0,
          total: 0));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
  }

  getOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();
    dynamic data = await APIService.getOrder(token);
    print(data);
    setState(() {
      order = Orders.fromJson(data);
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
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
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: AwesomeLoader(
                  loaderType: AwesomeLoader.AwesomeLoader3,
                  color: HexColor(Theme_Settings.loaderColor['color']),
                ))
          ])),
      renderError: ([error]) => Text('Something Went Wrong'),
      renderSuccess: ({data}) => order.data.length > 0
          ? SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                  for (var item in order.data) ...[
                    Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "Order No # " + item.id.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black),
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(14),
                                      child: Text(
                                        "Place on " +
                                            item.createdAt.substring(
                                                0, item.createdAt.indexOf('T')),
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ]),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Text(
                                "Received By " +
                                    item.customerFirstName.toString() +
                                    " " +
                                    item.customerLastName.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Text(
                                "Status " + item.status.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: item.status.toString() == "canceled"
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ),
                            ButtonBar(
                              children: <Widget>[
                                // RaisedButton(
                                //   child: const Text('Play'),
                                //   onPressed: () {/* ... */},
                                // ),

                                Text(
                                  "Total " +
                                      item.grandTotal.toString().substring(
                                            0,
                                            item.grandTotal
                                                .toString()
                                                .indexOf('.'),
                                          ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Paid By " + item.paymentTitle.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    margin: EdgeInsets.all(14),
                                    child: FlatButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      child: Text('View Detail'),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => OrderDetail(
                                                    id: item.id.toString())));
                                      },
                                    ))),
                          ],
                        ),
                      ),
                    )
                  ],
                ]))
          : new Center(
              child: Text("Empty"),
            ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "My Orders",
        ),
      ),
      body: _asyncLoader,
    );
  }
}
