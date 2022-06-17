import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../models/widgetjson.dart';

class ReviewsScreen extends StatefulWidget {
  int productId;
  ReviewsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState(this.productId);
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int tag = 1;
  late double userrating;
  TextEditingController comment = new TextEditingController();

  String comments = "";
  int productId;
  _ReviewsScreenState(this.productId);
  @override
  void initState() {
    // TODO: implement initState
    readJson();
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [],
        title: Text(
          "Reviews",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              "Rate Your Experience",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Text('Are your statisfied our Product?'),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  setState(() {
                    userrating = rating;
                  });
                },
              )),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: Text("Tell us what can be improved?"),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: TextFormField(
              controller: comment,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              onChanged: (val) {
                print(val);
                setState(() {
                  comments = val;
                });
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Review",
                hintStyle: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ),
          Center(
              child: Container(
            margin: EdgeInsets.all(14),
            width: 200,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: comments.toString().isEmpty
                  ? Colors.grey
                  : HexColor(getjson.banner[0].primaryColor),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () async {
                if (userrating != 0 &&
                    comment.text.isNotEmpty &&
                    productId > 0) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  String token =
                      preferences.getString("loggedIntoken").toString();
                  Rating rating = new Rating(userrating.toString(),
                      comment.text.toString(), comment.text.toString());

                  dynamic data = await APIService.Reviews(
                      rating.toJson(), token, productId.toString());

                  Fluttertoast.showToast(msg: data['message'].toString());

                  // print(data);
                } else {
                  Fluttertoast.showToast(msg: "Please fill the requirements");
                }
              },
            ),
          ))
        ],
      )),
    );
  }
}
