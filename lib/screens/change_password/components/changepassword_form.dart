import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:MakkiHerb/models/messageModel.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
// ignore: import_of_legacy_library_into_null_safe

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../models/widgetjson.dart';

class CompleteAddressEditForm extends StatefulWidget {
  @override
  _CompleteAddressEditFormState createState() =>
      _CompleteAddressEditFormState();
}

class _CompleteAddressEditFormState extends State<CompleteAddressEditForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  // late int id;
  dynamic emaili;
  bool hidepassword = true;
  bool? showpassword = false;

  bool hidepassword2 = true;
  bool? showpassword2 = false;

  bool hidepassword3 = true;
  bool? showpassword3 = false;

  String? gettoken;
  String? password;
  String? conform_password;

  bool showBack = false;
  String? profile;

  late FocusNode _focusNode;
  TextEditingController textoldpassword = TextEditingController();
  TextEditingController textconfirmpassword = TextEditingController();
  TextEditingController textpassword = TextEditingController();

  getprofiledata(String? data) async {
    GetDetail data = await GetDetail.getusername();

    //print(data.lastname);
    setState(() {
      emaili = data.email.toString();
      gettoken = data.token.toString();

      print("token getting" + gettoken.toString());
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  @override
  void initState() {
    super.initState();
    readJson();
    getprofiledata(gettoken);
    getprofiledata(emaili);
    print(gettoken);
    print(emaili);

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });

//textemail.text = "emailing";

    getprofiledata(profile);
//profileget();

    print("hello $gettoken");
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          buildoldPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          //  SizedBox(height: getProportionateScreenHeight(10)),

          Row(
            children: [
              Checkbox(
                value: showpassword,
                // activeColor: HexColor(getjson.banner[0].primaryColor),
                onChanged: (value) {
                  setState(() {
                    showpassword = value;
                    hidepassword = !hidepassword;
                  });
                },
              ),
              Text("Show Password"),
              Spacer(),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            primaryColor: getjson.banner.isNotEmpty
                ? getjson.banner[0].primaryColor
                : kPrimaryColor,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                changepass();
                KeyboardUtil.hideKeyboard(context);

                // if all are valid then go to success screen

              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildoldPasswordFormField() {
    return TextFormField(
      obscureText: hidepassword,
      controller: textoldpassword,
      // onSaved: (value) => password =value ,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Current Password",
          hintText: "Enter Current password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,

          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showpassword = showpassword;
                hidepassword = !hidepassword;
              });
            },
            child: IconButton(
              onPressed: () {
                setState(() {
                  showpassword = showpassword;
                  hidepassword = !hidepassword;
                });
              },
              icon: Icon(Icons.remove_red_eye),
            ),
          )),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: hidepassword2,
      controller: textconfirmpassword,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showpassword2 = showpassword2;
                hidepassword2 = !hidepassword2;
              });
            },
            child: IconButton(
              onPressed: () {
                setState(() {
                  showpassword2 = showpassword2;
                  hidepassword2 = !hidepassword2;
                });
              },
              icon: Icon(Icons.remove_red_eye),
            ),
          )),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidepassword3,
      controller: textpassword,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showpassword3 = showpassword3;
                hidepassword3 = !hidepassword3;
              });
            },
            child: IconButton(
              onPressed: () {
                setState(() {
                  showpassword3 = showpassword3;
                  hidepassword3 = !hidepassword3;
                });
              },
              icon: Icon(Icons.remove_red_eye),
            ),
          )),
    );
  }

  Future<void> changepass() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var getemail = preferences.getString('email');
    var token = preferences.getString('loggedIntoken');

    print(getemail);
    print(token);

    final msg = json.encode({
      'old_password': textoldpassword.text,
      'password': textpassword.text,
      'email': getemail
    });

    var res = await http.post(
        Uri.parse(Config.baseURL + Config.changepassword + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: msg);
    dynamic jsonDecoder = json.decode(res.body);
    debugPrint("Json Decode Data");

    print(jsonDecoder);

    MessageModel msgmodel = MessageModel.fromJson(jsonDecoder);

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: msgmodel.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      KeyboardUtil.hideKeyboard(context);

      print(res.body);

      print(res.statusCode);
    } else {
      print(res.statusCode);
      Fluttertoast.showToast(
          msg: msgmodel.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
