import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:MakkiHerb/models/ProfileModel.dart';
import 'package:MakkiHerb/models/errorModel.dart';
import 'package:MakkiHerb/models/profile.dart';
import 'package:MakkiHerb/models/resultmodel.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/screens/otp/otp_screen.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:date_format/date_format.dart';
import 'package:MakkiHerb/screens/profile/profile_screen.dart';
import 'complete_profile_pic.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  late ProfileData profileData;
  // late int id;
  String? gettoken;
  dynamic token;
  String? firstNames;
  String? lastNames;
  String? phone;
  dynamic emaili;
  String? date_of_birth;
  late int status;
  String? phonenumber;
  String? gender = "";
  String? profile;
// late Future<ProfileModel> futureProfile;
  //late String? _myDateTime;

  DateTime _date = DateTime(2004);
  String _mygender = "";

  TextEditingController textemail = TextEditingController();
  TextEditingController firstnametext = TextEditingController();
  TextEditingController lastnamestext = TextEditingController();
  TextEditingController phonetext = TextEditingController();
  TextEditingController dobtext = TextEditingController();
  TextEditingController gendertext = TextEditingController();

  getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.customerProfile(token);
    print(data);
    setState(() {
      profileData = ProfileData?.fromJson(data);
    });

    setState(() {
      textemail.text = profileData.data.email.toString() == null
          ? ""
          : profileData.data.email.toString();
      firstnametext.text = profileData.data.firstName.toString();
      lastnamestext.text = profileData.data.lastName.toString();
      phonetext.text = profileData.data.phone.toString() == null
          ? ""
          : profileData.data.phone.toString();
      dobtext.text = profileData.data.dateOfBirth.toString() == null
          ? profileData.data.dateOfBirth.toString()
          : "0000-01-01";
      gendertext.text = profileData.data.gender.toString();
      _mygender = profileData.data.gender.toString();
      token = data.token.toString();

      print(data.token.toString());
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
    getProfile();
    gettoken.toString();
    // getprofiledata(emaili);
//textemail.text = "emailing";
    // getprofiledata(lastNames);
    textemail.text = emaili;

    profileget();
    gettoken = token;
    print("hello $gettoken");
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildGenderFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildDOBFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              KeyboardUtil.hideKeyboard(context);
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                profilepost();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: phonetext,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastnamestext,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
          //allow upper and lower case alphabets and space
          return "Enter Correct Name";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: textemail,
      // TextEditingController(text: emaili),

      // onSaved: (value) => email =value ,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          removeError(error: "Enter Email");
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Email");
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: "Invalid Email");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",

        hintText: "Enter your Email Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      // onSaved: (newValue) => firstNames= newValue,
      controller: firstnametext,

      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kfirstNamelNullError);
        }

        return null;
      },
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
          //allow upper and lower case alphabets and space
          return "Enter Correct Name";
        } else {
          return null;
        }
      },

      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<dynamic> profileget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("loggedIntoken").toString();

    // dynamic data=await APIService.profileget(token);
    // debugPrint("New Calling APi");
    // print(token);
    // print(data);
    final res = await http.get(
        Uri.parse(Config.baseURL + Config.profilegetapi + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });

    if (res.statusCode == 200) {
      setState(() {
        dynamic jsonDecoder = json.decode(res.body);
        debugPrint("Json Decode Data");

        print(jsonDecoder);

        ResultModel responsedata = ResultModel.fromJson(jsonDecoder);

        lastnamestext.text = responsedata.data.lastName;
        firstnametext.text = responsedata.data.firstName;
        phonetext.text = responsedata.data.phone;
        firstNames = responsedata.data.firstName;
      });

      firstNames = firstNames.toString();
      print('Firstnsmae $firstNames');
      print('Bearer $token');
      Fluttertoast.showToast(msg: 'sucessful');
    }
  }

  profilepost() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("loggedIntoken").toString();
    print(token);

    final msg = json.encode({
      'email': textemail.text,
      'first_name': firstnametext.text,
      'last_name': lastnamestext.text,
      'gender': gendertext.text,
      'phone': phonetext.text.toString()
    });
    var res = await http.post(
        Uri.parse(Config.baseURL + Config.profilepostapi + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: msg);

    dynamic jsonDecoder = json.decode(res.body);

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: jsonDecoder['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      KeyboardUtil.hideKeyboard(context);

      print(res.statusCode);
    } else if (res.statusCode == 401) {
      ErrorModel responsedata = ErrorModel.fromJson(jsonDecoder);
      print(responsedata.error);
      print(res.statusCode);

      Fluttertoast.showToast(
          msg: responsedata.error.toString(),
          //  msg:'error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      ErrorModel responsedata = ErrorModel.fromJson(jsonDecoder);
      print(responsedata.error);
      print(res.statusCode);
      Fluttertoast.showToast(
          msg: responsedata.error.toString(),
          //  msg:'error in network',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      print(res.statusCode);
    }
  }
}
