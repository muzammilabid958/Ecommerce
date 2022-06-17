import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:MakkiHerb/screens/complete_profile/complete_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? firstname;
  String? lastname;
  String? password;
  String? phone;
  String? conform_password;
  bool remember = false;

  TextEditingController textemail = new TextEditingController();
  TextEditingController textfirsrname = new TextEditingController();
  TextEditingController textlastname = new TextEditingController();
  TextEditingController textconfirmpassword = new TextEditingController();
  TextEditingController textpassword = new TextEditingController();
  TextEditingController textphone = new TextEditingController();

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildfirstnameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildlastnameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                signup();
              }
            },
          ),
        ],
      ),
    );
  }

  bool hidepassword = true;
  bool? showpassword = false;
  bool hidepassword2 = true;
  bool? showpassword2 = false;
  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 13,
      controller: textphone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "Enter Phone Number";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
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
          return "Enter Password";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "Password must be atlease 6 character";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
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
      obscureText: hidepassword,
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
          return "Enter Password";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "Password must be atlease 6 character";
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
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "Enter Email";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "Enter Correct Email";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildfirstnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: textfirsrname,
      onSaved: (newValue) => firstname = newValue,
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
        hintText: "Enter your First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }

  TextFormField buildlastnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: textlastname,
      onSaved: (newValue) => lastname = newValue,
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
        hintText: "Enter your Last Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }

  Future<void> signup() async {
    var res = await http.post(Uri.parse(Config.registerapi),
        body: ({
          'email': textemail.text,
          'first_name': textfirsrname.text,
          'last_name': textlastname.text,
          'password': textpassword.text,
          'password_confirmation': textconfirmpassword.text,
          'phone': textphone.text
        }));

    if (res.statusCode == 200) {
      KeyboardUtil.hideKeyboard(context);

      var res = await http.post(Uri.parse(Config.baseURL + Config.otpapi),
          body: ({'email': textemail.text}));

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString("registerEmail", textemail.text.toString());

      print(res.body);
      Navigator.pushNamed(context, OtpScreen.routeName);

      print(res.statusCode);
    } else if (res.statusCode == 401) {
      print(res.statusCode);
      Fluttertoast.showToast(
          msg: "Wrong Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      print("wrong credentials");
    } else if (res.statusCode == 302) {
      print(res.statusCode);
      Fluttertoast.showToast(
          msg: "UserName is already available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      print("user available");
    } else {
      Fluttertoast.showToast(
          msg: "Network Issue",
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
