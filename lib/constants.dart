import 'package:flutter/material.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:hexcolor/hexcolor.dart';

const kPrimaryColor = "#13743F";
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don’t match";
const String kNamelNullError = "Please Enter your name";
const String kfirstNamelNullError = "Please Enter your first name";
const String klastNamelNullError = "Please Enter your last name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kCardHolderNameNullError = "Please Enter card holder name";
const String kCVVNullError = "Please Enter CVV";
const String kCardNumberNullError = "Please Enter your card number";
const String kCardExpiryNullError = "Please Enter your card Expiry";
const String kAddressNullError = "Please Enter your address";
const String kCityNullError = "Please Enter your City";
const String kPaymentMethodNullError = "Please Select payment method";
const String kzipcodeNullError = "Please Enter the Zip Code";
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  counterText: "",
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
