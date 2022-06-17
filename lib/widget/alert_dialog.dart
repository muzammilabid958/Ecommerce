import 'dart:convert';

import 'package:MakkiHerb/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/login_model.dart';
import 'package:MakkiHerb/models/logoutmodel.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constant/api_services.dart';
import '../models/widgetjson.dart';

enum DialogAction { Accept, Cancel }

class AlertDialogs {
  static yesCancelDialogue(
    BuildContext context,
    String title,
    String body,
  ) async {
    final jsondata = await APIService.jsonfile();

    widgetjson getjson = widgetjson(banner: []);
    getjson = widgetjson.fromJson(jsondata);
    await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(DialogAction.Cancel),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: HexColor(getjson.banner.isNotEmpty
                            ? getjson.banner[0].primaryColor
                            : kPrimaryColor),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear();

                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                )
              ]);
        });
  }

  static Future<void> logout() async {
    var response = await http.get(Uri.parse(Config.logoutapi));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonres = loginfromjson(jsonDecode(response.body));
      print(jsonres);

      // Fluttertoast.showToast(
      //       msg: jsonres,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.grey,
      //       textColor: Colors.white,
      //       fontSize: 16.0
      //   );

    }

    print(response.statusCode);

// Fluttertoast.showToast(
//         msg: "Some Error",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );

//     print(response.statusCode);
  }
}
