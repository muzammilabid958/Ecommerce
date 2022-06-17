import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/size_config.dart';

class ReviewSuccessScreen extends StatefulWidget {
  ReviewSuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ReviewSuccessScreenState createState() => _ReviewSuccessScreenState();
}

class _ReviewSuccessScreenState extends State<ReviewSuccessScreen> {
  static String routeName = "/order_success";

  String orderno = "";

  _ReviewSuccessScreenState();

  @override
  void initState() {
    // TODO: implement initState\
  }
  void moveToLastScreen() {
    Navigator.of(context).pushNamed('/home');
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
            leading: SizedBox(),
            title: Text("Review Success"),
          ),
          body: Center(
              child: Column(
            children: [
              Image.asset(
                "assets/images/success.png",
                width: 400,
                height: 400, //40%
              ),
              Text(
                "Review Success",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Review Submitted Success"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.6,
                child: DefaultButton(
                  text: "Back to home",
                  press: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
              ),
              // Spacer(),
            ],
          )),
        ));
  }
}
