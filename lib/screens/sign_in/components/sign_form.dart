import 'dart:developer';
import 'dart:convert';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MakkiHerb/models/LoggedInUser.dart';
import 'package:MakkiHerb/models/login_model.dart';
import 'package:MakkiHerb/screens/forgot_password/forgot_password_screen.dart';
import 'package:MakkiHerb/screens/login_success/login_success_screen.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/screens/sign_up/components/body.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

@override
Widget build(BuildContext context) {
  return Container();
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  bool? showpassword = false;
  bool hidepassword = true;
  // late LoginRequestModel requestModel;
//ate LoginRequestModel loginRequest;
  TextEditingController textemail = new TextEditingController();
  TextEditingController textpassword = new TextEditingController();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('loggedIntoken');
    if (token != null) {
      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Continue",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  login();
                }
              }),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidepassword,
      controller: textpassword,
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
          labelText: "Password",
          hintText: "Enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: textemail,

      // onSaved: (value) => email =value ,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  Future<void> login() async {
    var res = await http.post(Uri.parse(Config.baseURL + Config.loginapi),
        body: ({
          'email': textemail.text,
          'password': textpassword.text,
          'token': 'true'
        }));

    var data = jsonDecode(res.body);
    print(data);
    if (res.statusCode == 200) {
      KeyboardUtil.hideKeyboard(context);

      LoggedInUser loggedInUser = LoggedInUser.fromJson(data);
      print("Login Json Data");
      print(data);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("UserID", loggedInUser.data.id.toString());
      preferences.setString("id", loggedInUser.data.id.toString());
      preferences.setString("email", loggedInUser.data.email.toString());
      preferences.setString(
          "first_name", loggedInUser.data.firstName.toString());
      preferences.setString("last_name", loggedInUser.data.lastName.toString());
      preferences.setString("name", loggedInUser.data.name.toString());
      preferences.setString(
          "date_of_birth", loggedInUser.data.dateOfBirth.toString());
      preferences.setString("phone", loggedInUser.data.phone.toString());
      preferences.setString("gender", loggedInUser.data.gender.toString());
      preferences.setString("profile", loggedInUser.data.profile.toString());

      preferences.setString("loggedIntoken", loggedInUser.token.toString());
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else if (data['status'] == 401) {
      var data = jsonDecode(res.body);
      print(data);
      Fluttertoast.showToast(
          msg: data['error'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (res.statusCode == 405) {
      var data = jsonDecode(res.body);
      print(data);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("registerEmail", textemail.text.toString());
      Fluttertoast.showToast(
          msg: data['error'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushNamed(context, OtpScreen.routeName);
    } else {
      Fluttertoast.showToast(
          msg: "Network Issue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
