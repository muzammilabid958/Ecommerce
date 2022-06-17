import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDetail {
  int? id;
  String? token;
  String? name;
  String? email;
  String? lastname;
  String? dateofbirth;
  String? first_name;
  String? phone;
  String? gender;
  String? profile;

  GetDetail(token, id, email, firstName, lastname, name, dateofbirth, phone,
      gender, profile) {
    this.token = token;
    this.id = id;
    this.name = name;
    this.email = email;
    this.lastname = lastname;
    this.dateofbirth = dateofbirth;
    this.first_name = firstName;
    this.phone = phone;
    this.gender = gender;
    this.profile = profile;
  }

  static Future<GetDetail> getusername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return GetDetail(
        pref.getString("loggedIntoken").toString(),
        int.parse(pref.getString("id").toString()),
        pref.getString("email").toString(),
        pref.getString("first_name").toString(),
        pref.getString("last_name").toString(),
        pref.getString("name").toString(),
        pref.getString("date_of_birth").toString(),
        pref.getString("phone").toString(),
        pref.getString("gender").toString(),
        pref.getString("profile").toString());
  }
}
