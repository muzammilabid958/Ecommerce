import 'dart:async';

import 'dart:math' as math;
import 'package:MakkiHerb/screens/shipment/shipment_screen.dart';
import 'package:MakkiHerb/screens/shipment/shipping_list_guest.dart';
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
import 'package:MakkiHerb/screens/addresslist/address_screen.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/screens/otp/otp_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../../../constants.dart';
import '../../../models/GuestShipingAddress.dart';
import '../../../models/ShippingForGuest.dart';
import '../../../models/widgetjson.dart';
import '../../../size_config.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hexcolor/hexcolor.dart';

class ShipmentFormGuest extends StatefulWidget {
  @override
  _ShipmentFormGuestState createState() => _ShipmentFormGuestState();
}

class _ShipmentFormGuestState extends State<ShipmentFormGuest> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  // late int id;
  String? gettoken;

  String dropdownValuecity = "";
  String dropdownValuestate = "";
  bool showBack = false;
  String? profile;

  TextEditingController zipController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController textemail = TextEditingController();

  late FocusNode _focusNode;
  bool onPressedValue = true;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();
    final data = json.decode(jsondata);
    setState(() {
      getjson = widgetjson.fromJson(jsondata);
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
    readJson();

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          buildfirstname(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildlastname(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressfield(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCountryField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStateField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCityField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildZipcodeFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          onPressedValue == true
              ? DefaultButton(
                  text: "Continue",
                  press: onPressedValue == true
                      ? () async {
                          setState(() {
                            onPressedValue = false;
                          });
                          Timer(Duration(seconds: 5), () {
                            setState(() {
                              onPressedValue = true;
                            });
                          });

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            GuestShippingAdresses shippingAdresses1 =
                                GuestShippingAdresses(
                                    billing: Billing(
                                        address1: Address1(
                                            address: addressController.text
                                                .toString()),
                                        city: cityController.text.toString(),
                                        country:
                                            countryController.text.toString(),
                                        email: textemail.text.toString(),
                                        firstName:
                                            firstnameController.text.toString(),
                                        lastName:
                                            lastnameController.text.toString(),
                                        phone: phoneController.text.toString(),
                                        postcode: zipController.text.toString(),
                                        state: stateController.text.toString(),
                                        useForShipping: "true"),
                                    shipping: Shipping(
                                        address1: Address1(
                                            address: addressController.text
                                                .toString())));

                            dynamic data = await APIService.saveAdressAsGuest(
                                shippingAdresses1);
                            print(data);
                            ShippmentForGuest guest =
                                ShippmentForGuest.fromJson(data);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ShippingListGuest(data: guest)));
                          }
                        }
                      : null,
                )
              : Container(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  TextFormField buildCountryField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: countryController,
        inputFormatters: [new LengthLimitingTextInputFormatter(60)],
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Enter Country");
          }

          return null;
        },
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            //allow upper and lower case alphabets and space
            return "Enter Correct Country";
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          labelText: "Country Name",
          hintText: "Enter Your Country Name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildfirstname() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: firstnameController,
        inputFormatters: [new LengthLimitingTextInputFormatter(60)],
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Enter First Name");
          }

          return null;
        },
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            //allow upper and lower case alphabets and space
            return "Enter First Name";
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          labelText: "First Name",
          hintText: "Enter Your First Name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildlastname() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: lastnameController,
        inputFormatters: [new LengthLimitingTextInputFormatter(60)],
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Enter Last Name");
          }

          return null;
        },
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            //allow upper and lower case alphabets and space
            return "Enter Last Name";
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          labelText: "Last Name",
          hintText: "Enter Your Last Name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildPhoneField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: phoneController,
        inputFormatters: [new LengthLimitingTextInputFormatter(60)],
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Enter Phone Number");
          }
          setState(() {
            // cardHolderName = value;
          });
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: "Enter Phone Number");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Phone Number",
          hintText: "Enter Your Phone Number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
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

  TextFormField buildCityField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: cityController,
        inputFormatters: [new LengthLimitingTextInputFormatter(60)],
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Enter City");
          }

          return null;
        },
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            //allow upper and lower case alphabets and space
            return "Enter Correct City";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: "City",
          hintText: "Enter Your City",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildStateField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: stateController,
      inputFormatters: [new LengthLimitingTextInputFormatter(60)],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter State");
        }

        return null;
      },
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
          //allow upper and lower case alphabets and space
          return "Enter Correct State";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: "State",
        hintText: "Enter Your State",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressfield() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: addressController,
      inputFormatters: [new LengthLimitingTextInputFormatter(60)],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        setState(() {
          // cardHolderName = value;
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
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter Your Address",
        prefixIcon: GestureDetector(
          child: Icon(Icons.location_pin),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PlacePicker(
                    apiKey: "AIzaSyBAgOEteCv3TMp2Y09u-R-uHypaDaq16MY",
                    initialPosition: LatLng(-33.8567844, 151.213108),
                    useCurrentLocation: true,
                    selectInitialPosition: true,
                    onPlacePicked: (result) async {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              result.geometry!.location.lat,
                              result.geometry!.location.lng);

                      setState(() {
                        addressController.text =
                            result.formattedAddress.toString();
                        countryController.text =
                            placemarks[0].country.toString();
                        cityController.text = placemarks[0].locality.toString();
                        zipController.text =
                            placemarks[0].postalCode.toString();
                      });
                      Navigator.pop(context);
                    },
                    region: 'pk',
                    selectedPlaceWidgetBuilder:
                        (_, selectedPlace, state, isSearchBarFocused) {
                      return isSearchBarFocused
                          ? Container()
                          : FloatingCard(
                              color: HexColor(getjson.banner.isNotEmpty
                                  ? getjson.banner[0].primaryColor
                                  : kPrimaryColor),
                              bottomPosition:
                                  50.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                              leftPosition: 50.0,
                              rightPosition: 50.0,
                              width: 500,
                              borderRadius: BorderRadius.circular(12.0),
                              child: state == SearchingState.Searching
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      selectedPlace!
                                                          .formattedAddress
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  RaisedButton(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 10, 15, 10),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      onPressed: () async {
                                                        List<Placemark>
                                                            placemarks =
                                                            await placemarkFromCoordinates(
                                                                selectedPlace
                                                                    .geometry!
                                                                    .location
                                                                    .lat,
                                                                selectedPlace
                                                                    .geometry!
                                                                    .location
                                                                    .lng);
                                                        print(placemarks);
                                                        setState(() {
                                                          addressController
                                                                  .text =
                                                              selectedPlace
                                                                  .formattedAddress
                                                                  .toString();
                                                          countryController
                                                                  .text =
                                                              placemarks[0]
                                                                  .country
                                                                  .toString();

                                                          cityController.text =
                                                              placemarks[0]
                                                                  .locality
                                                                  .toString();
                                                          zipController.text =
                                                              placemarks[0]
                                                                  .postalCode
                                                                  .toString();
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                      color: Colors.white,
                                                      child: const Text(
                                                        "Confirm Location",
                                                      ))
                                                ]),
                                          ]),
                                    ),
                            );
                    },
                  );
                },
              ),
            );
          },
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    print(place);
    setState(() {});
  }

  TextFormField buildCVVFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly
      ],

      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCVVNullError);
        }
        setState(() {
          // cvv = value;
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
        // suffixIcon: Icon(Icons.numbers_rounded),
      ),
    );
  }

  TextFormField buildZipcodeFormField() {
    return TextFormField(
      // onSaved: (newValue) => firstNames= newValue,
      controller: zipController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kzipcodeNullError);

          setState(() {
            //     cardNumber = newStr;
          });
        }
        return null;
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kzipcodeNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Zip Code",

        hintText: "Enter Zip Code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: Icon(Icons.area_chart_rounded),
        //CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
