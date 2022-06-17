// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'models/widgetjson.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeValues {
  widgetjson? getjson;

  ThemeValues();

  static ThemeData theme(String font1, String? font2, String fontcolor,
      String themebackgroundcolor, String appbarcolor, String buttoncolor) {
    return ThemeData(
      scaffoldBackgroundColor:
          //Colors.lime,
          HexColor(themebackgroundcolor),
      fontFamily: "Muli",
      appBarTheme: appBarTheme(appbarcolor),
      textTheme: textTheme(font1, font2, fontcolor, buttoncolor),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: kTextColor),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      // If  you are using latest version of flutter then lable text and hint text shown like this
      // if you r using flutter less then 1.20.* then maybe this is not working properly
      // if we are define our floatingLabelBehavior in our theme then it's not applayed
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }

  static TextTheme textTheme(
      String f1, String? f2, String fcolor, String? buttoncolor) {
    //readsharedpref();

    //readJson();
    // ignore: avoid_print

    return TextTheme(
      bodyText1: GoogleFonts.getFont(f1.isNotEmpty ? f1 : "Poppins",
          color: Color(int.parse(fcolor.isNotEmpty ? fcolor : "0xfffc9918"))),
      // TextStyle(color: kTextColor),
      bodyText2: GoogleFonts.getFont(f2 ?? "Poppins",
          color: Color(int.parse(fcolor.isNotEmpty ? fcolor : "0xfffc9918"))),

      button: GoogleFonts.getFont(f2 ?? "Poppins",
          color: Color(int.parse(buttoncolor ?? "0xfffc9918"))),
    );
  }

  static AppBarTheme appBarTheme(String appbarcolor) {
    return AppBarTheme(
      color: HexColor("#f7f2f2"),
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    );
  }
}
