import 'dart:async';

import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/components/custom_surfix_icon.dart';
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/components/form_error.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:MakkiHerb/models/FetchAddress.dart';
import 'package:MakkiHerb/models/ProfileModel.dart';
import 'package:MakkiHerb/models/errorModel.dart';
import 'package:MakkiHerb/models/resultmodel.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/screens/otp/otp_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  static const IconData credit_card =
      IconData(0xe19f, fontFamily: 'MaterialIcons');
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  // late int id;
  String? gettoken;
  dynamic token;
  String? firstNames;
  String? lastNames;
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  String dropdownValue = "Select Payment Method";
  String dropdownAddress = "";
  bool showBack = false;
  String? profile;

  DateTime _date = DateTime(2004);
  String _mygender = "";

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  dynamic textemail = TextEditingController();
  dynamic firstnametext = TextEditingController();
  dynamic lastnamestext = TextEditingController();
  dynamic phonetext = TextEditingController();
  dynamic cardholderName = TextEditingController();
  dynamic dobtext = TextEditingController();
  dynamic gendertext = TextEditingController();
  dynamic addresstext = TextEditingController();
  List<dynamic> listofAddress = [];
  getprofiledata(String? data) async {
    GetDetail data = await GetDetail.getusername();
    //print(data.lastname);
    setState(() {
      textemail.text = data.email.toString();
      firstnametext.text = data.first_name.toString();
      lastnamestext.text = data.lastname.toString();
      phonetext.text = data.phone.toString();
      dobtext.text = data.dateofbirth.toString();
      gendertext.text = data.gender.toString();
      _mygender = data.gender.toString();
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
    gettoken.toString();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });

    getprofiledata(lastNames);

    getprofiledata(profile);

    getAddress();

    gettoken = token;
  }

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.getAddress(token);
    print("Address Data");
    print(data);
    FetchAddress address = new FetchAddress.fromJson(data);
    for (var i = 0; i < address.data.length; i++) {
      for (var j = 0; j < address.data[i].address1.length; i++) {
        setState(() {
          listofAddress.add(
            {
              "display": address.data[i].address1[j].toString(),
              "value": address.data[i].address1[j].toString(),
            },
          );
        });
      }
    }
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

  String _myActivity = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CreditCard(
            cardNumber: cardNumber,
            cardExpiry: expiryDate,
            cardHolderName: cardHolderName,
            cvv: cvv,
            bankName: 'Axis Bank',
            showBackSide: showBack,
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            // mask: getCardTypeMask(cardType: CardType.americanExpress),
          ),
          SizedBox(
            height: 40,
          ),
          buildPayMethodFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildCardNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DropDownFormField(
            value: dropdownAddress,
            onChanged: (newValue) {
              Fluttertoast.showToast(msg: newValue.toString());
              // if (newValue.isNotEmpty) {
              //   removeError(error: kAddressNullError);
              // }

              setState(() {
                this.dropdownAddress = newValue;
              });

              // return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPaymentMethodNullError);
                return "";
              }
              return null;
            },
            titleText: 'Address',
            hintText: "Select Address",
            dataSource: listofAddress,
            textField: 'display',
            valueField: 'value',
          ),

          SizedBox(height: getProportionateScreenHeight(30)),

          buildCardExpiryFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCardHolderNamefield(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCVVFormField(),
          // buildDOBFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          //buildShippingAddressFormField(),
          //  SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                KeyboardUtil.hideKeyboard(context);
                Fluttertoast.showToast(msg: 'Successful');
                print(dropdownValue);

                // if all are valid then go to success screen

              }
            },
          ),
        ],
      ),
    );
  }

  DropDownFormField buildPayMethodFormField() {
    return DropDownFormField(
      value: dropdownValue,
      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        setState(() {
          dropdownValue = newValue;
        });

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPaymentMethodNullError);
          return "";
        }
        return null;
      },
      titleText: 'Payment Method',
      hintText: "Select Payment Method",
      dataSource: [
        {
          "display": "COD",
          "value": "COD",
        },
        {
          "display": "Debit Card",
          "value": "Debit Card",
        },
        {
          "display": "Select Payment Method",
          "value": "Select Payment Method",
        },
        {"display": "Credit Card", "value": "Credit Card"},
        {"display": "JazzCash", "value": "JazzCash"}
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  DropDownFormField buildAddress() {
    return DropDownFormField(
      // value:"Select Payment Method",

      value: dropdownAddress,
      //onSaved: (newValue) => addres = newValue,

      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        setState(() {
          dropdownAddress = newValue;
        });

        return null;
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      titleText: 'Address',
      hintText: "Select Address",

      dataSource: listofAddress,
      textField: 'address',
      valueField: 'address',
    );
  }

  TextFormField buildCardHolderNamefield() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: cardholderName,
      inputFormatters: [
        new LengthLimitingTextInputFormatter(15),
        FilteringTextInputFormatter.singleLineFormatter
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCardHolderNameNullError);
        }
        setState(() {
          cardHolderName = value;
        });
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCardHolderNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Card Holder Name",
        hintText: "Enter Card Holder Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.supervised_user_circle_rounded),
      ),
    );
  }

  TextFormField buildCardExpiryFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,

      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: expiryFieldCtrl,
      //onSaved: (newValue) => lastNames = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCardHolderNameNullError);
        }
        var newDateValue = value.trim();
        final isPressingBackspace = expiryDate.length > newDateValue.length;
        final containsSlash = newDateValue.contains('/');

        if (newDateValue.length >= 2 &&
            !containsSlash &&
            !isPressingBackspace) {
          newDateValue =
              newDateValue.substring(0, 2) + '/' + newDateValue.substring(2);
        }
        setState(() {
          expiryFieldCtrl.text = newDateValue;
          expiryFieldCtrl.selection = TextSelection.fromPosition(
              TextPosition(offset: newDateValue.length));
          expiryDate = newDateValue;
        });
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCardExpiryNullError);
          return "";
        }
        return null;
      },

      decoration: InputDecoration(
        labelText: "Card Expiry",
        hintText: "Enter Card Expiry",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.date_range_rounded),
      ),
    );
  }

  TextFormField buildCVVFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: addresstext,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCVVNullError);
        }
        setState(() {
          cvv = value;
        });
        return null;
      },
      focusNode: _focusNode,

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCardExpiryNullError);
          return "";
        }
        return null;
      },

      //onSaved: (newValue) => lastNames = newValue,
      decoration: InputDecoration(
        labelText: "CVV",
        hintText: "Enter your CVV",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.format_list_numbered),
      ),
    );
  }

  TextFormField buildCardNumberFormField() {
    return TextFormField(
      // onSaved: (newValue) => firstNames= newValue,
      controller: cardNumberCtrl,
      keyboardType: TextInputType.number,

      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
          final newCardNumber = value.trim();
          var newStr = '';
          final step = 4;

          for (var i = 0; i < newCardNumber.length; i += step) {
            newStr += newCardNumber.substring(
                i, math.min(i + step, newCardNumber.length));
            if (i + step < newCardNumber.length) newStr += ' ';
          }

          setState(() {
            cardNumber = newStr;
          });
        }
        return null;
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCardNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Card Number",

        hintText: "Enter Card Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.credit_card),
        //CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
