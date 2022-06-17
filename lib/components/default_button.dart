import 'dart:convert';

import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../constant/api_services.dart';
import '../constants.dart';
import '../size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:async_loader/async_loader.dart';
import 'package:awesome_loader/awesome_loader.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.primaryColor,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final String? primaryColor;

  @override
  _DefaultButtonState createState() => _DefaultButtonState(
        text,
        press,
        primaryColor,
      );
}

class _DefaultButtonState extends State<DefaultButton> {
  final String? text;
  final Function? press;
  final String? primaryColor;
  _DefaultButtonState(
    this.text,
    this.press,
    this.primaryColor,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: APIService.jsonfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            ));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              widgetjson getjson = widgetjson.fromJson(snapshot.data);
              return SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: getjson.banner.isNotEmpty
                        ? HexColor(getjson.banner[0].primaryColor)
                        : HexColor(kPrimaryColor),
                  ),
                  onPressed: press as void Function()?,
                  child: Text(
                    text!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}
