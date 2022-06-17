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
import 'package:MakkiHerb/models/ProfileModel.dart';
import 'package:MakkiHerb/models/ShippingAddress.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [],
      ),
    );
  }
}
