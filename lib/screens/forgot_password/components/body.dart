import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/ForgetPasswordEmailRequest.dart';
import 'package:MakkiHerb/models/forgetPasswordOTP.dart';
import 'package:MakkiHerb/screens/forgot_password/forgetPasswordotp/components/otp_form.dart';
import 'package:MakkiHerb/screens/forgot_password/forgetPasswordotp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:MakkiHerb/components/no_account_text.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () async {
              SharedPreferences preference =
                  await SharedPreferences.getInstance();
              if (_formKey.currentState!.validate()) {
                preference.setString(
                    "ResetPasswordEmail", emailController.text.toString());
                dynamic data = await APIService.ForgetPasswordRequest(
                    new ForgetEmailOTP(emailController.text));
                ForgetPasswordEmailRequest passwordEmailRequest =
                    ForgetPasswordEmailRequest.fromJson(data);
                if (passwordEmailRequest.status == "200") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ForgetPasswordOtpScreen()));
                } else {
                  Fluttertoast.showToast(
                      msg: passwordEmailRequest.message.toString());
                }
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
