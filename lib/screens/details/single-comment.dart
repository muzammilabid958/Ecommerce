import 'dart:convert';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/models/ReviewsByID.dart';
import 'package:awesome_loader/awesome_loader.dart';
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
import 'package:MakkiHerb/models/ReviewsByID.dart' as ReviewByID;
import 'package:MakkiHerb/models/SaveAddress.dart';
import 'package:MakkiHerb/screens/orders/orderdetail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class single_comment extends StatefulWidget {
  static String routeName = "/details";
  String id;
  single_comment(this.id, {Key? key}) : super(key: key);

  @override
  _single_commentState createState() => _single_commentState(id);
}

class _single_commentState extends State<single_comment> {
  ReviewByID.ReviewsByID reviews = new ReviewByID.ReviewsByID(data: []);
  String id;
  _single_commentState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviews();
  }

  getReviews() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    dynamic data = await APIService.GetReviewsByProductID(this.id);

    setState(() {
      reviews = ReviewByID.ReviewsByID.fromJson(data);
      print(data);
      print(reviews.data.map((e) => e.customer.profile));
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
                )),
          ])),
      renderError: ([error]) => Text('Something Went Wrong'),
      renderSuccess: ({data}) => reviews.data.length > 0
          ? SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                  for (var i = 0; i < reviews.data.length; i++) ...[
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
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.brown.shade800,
                                            backgroundImage: NetworkImage(
                                                reviews.data[i].customer.profile
                                                    .toString()),
                                          ),
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                reviews.data[i].customer.name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(14),
                                      child: Text(
                                        "Created on: " +
                                            reviews.data[i].customer.createdAt
                                                .toString()
                                                .substring(
                                                    0,
                                                    reviews.data[i].customer
                                                        .createdAt
                                                        .toString()
                                                        .indexOf('T')),
                                        style: TextStyle(fontSize: 10),
                                      )),
                                ]),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                reviews.data[i].customer.email.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                            //   child: Text(
                            //     reviews.data[i].title.toString(),
                            //     style: TextStyle(
                            //         fontSize: 25, fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                              child: Text(
                                reviews.data[i].comment.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ButtonBar(
                              children: <Widget>[
                                // RaisedButton(
                                //   child: const Text('Play'),
                                //   onPressed: () {/* ... */},
                                // ),
                                RatingBarIndicator(
                                  rating: double.parse(reviews.data[i].rating),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),

                                // Text(
                                //   "Total " +

                                //             reviews.data[i].comment
                                //                 .toString()

                                //           ,
                                //   style: const TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                // Text(
                                //   "Paid By" + reviews.data[i].rating.toString(),
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                            // Align(
                            //     alignment: Alignment.topRight,
                            //     child: Container(
                            //         margin: EdgeInsets.all(14),
                            //         child: FlatButton(
                            //           shape: new RoundedRectangleBorder(
                            //               borderRadius:
                            //                   new BorderRadius.circular(30.0)),
                            //           child: Text('View Detail'),
                            //           onPressed: () {
                            //             Navigator.of(context).push(
                            //                 MaterialPageRoute(
                            //                     builder: (_) => OrderDetail(
                            //                         id: reviews.data[i].id.toString())));
                            //           },
                            //         ))),
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
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "All Comments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _asyncLoader,
    );
  }
}
