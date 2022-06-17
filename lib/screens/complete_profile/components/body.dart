import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/screens/complete_profile/Getdetails.dart';
import 'package:MakkiHerb/screens/complete_profile/components/complete_profile_pic.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constant/config.dart';
import '../../../helper/keyboard.dart';
import '../../../models/errorModel.dart';
import '../../../models/profile.dart' as ProfileData;
import '../../../models/resultmodel.dart';
import '../../profile/profile_screen.dart';
import 'complete_profile_form.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

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

  DateTime _date = DateTime(2004);
  String _mygender = "";

  TextEditingController textemail = TextEditingController();
  TextEditingController firstnametext = TextEditingController();
  TextEditingController lastnamestext = TextEditingController();
  TextEditingController phonetext = TextEditingController();
  TextEditingController dobtext = TextEditingController();
  TextEditingController gendertext = TextEditingController();

  getprofiledata(String? data) async {
    GetDetail data = await GetDetail.getusername();

    setState(() {
      //print(data.lastname);
      name = data.name;
    });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  String? name;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.customerProfile(token);

    ProfileData.ProfileData profileData =
        ProfileData.ProfileData.fromJson(data);

    setState(() {
      textemail.text = profileData.data.email.toString() == "null"
          ? ""
          : profileData.data.email.toString();
      firstnametext.text = profileData.data.firstName.toString();
      lastnamestext.text = profileData.data.lastName.toString();
      phonetext.text = profileData.data.phone.toString() == "null"
          ? ""
          : profileData.data.phone.toString();
      dobtext.text = profileData.data.dateOfBirth.toString() == "null"
          ? profileData.data.dateOfBirth.toString()
          : "0000-01-01";
      gendertext.text = profileData.data.gender.toString();
      _mygender = profileData.data.gender.toString();
      // token = data.token.toString();

      // print(data.token.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Editing Profile", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm1(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
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
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: textemail,
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
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your Email Address",
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

      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter First Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<dynamic> profileget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("loggedIntoken").toString();

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
}

class CompleteProfileForm1 extends StatefulWidget {
  @override
  _CompleteProfileForm1State createState() => _CompleteProfileForm1State();
}

class _CompleteProfileForm1State extends State<CompleteProfileForm1> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  ProfileData.ProfileData profileData = ProfileData.ProfileData(
      data: ProfileData.Data(
          id: 0,
          email: "",
          firstName: "",
          lastName: "",
          name: "",
          gender: "",
          dateOfBirth: "",
          phone: "",
          profile: "",
          emailVerified: 0,
          status: 0,
          createdAt: "",
          updatedAt: ""));
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
      profileData = ProfileData.ProfileData?.fromJson(data);
    });

    setState(() {
      textemail.text = profileData.data.email.toString().isEmpty
          ? ""
          : profileData.data.email.toString();
      //  preferences.getString("profile_email").toString();

      firstnametext.text = profileData.data.firstName.toString();
      lastnamestext.text = profileData.data.lastName.toString();
      phonetext.text = profileData.data.phone.toString() == "null"
          ? ""
          : profileData.data.phone.toString();
      dobtext.text = profileData.data.dateOfBirth.toString() == null
          ? profileData.data.dateOfBirth.toString()
          : "0000-01-01";
      gendertext.text = profileData.data.gender.toString();
      _mygender = profileData.data.gender.toString();
      // token = data.token.toString();

      // print(data.token.toString());
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  static File? _file;
  Future pickImagesforCamera() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.camera);
      if (images == null) return;
      final imageTemp = File(images.path);
      setState(() => _file = imageTemp);
    } on PlatformException catch (e) {
      print(e);
    }
  }

//gallery call
  Future pickImage() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      final imageTemp = File(images.path);

      setState(() => _file = imageTemp);
    } on PlatformException catch (e) {
      print(e);
    }
    print(_file);
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            const Text(
              "Choose Profile Photo",
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                  icon: Icon(IconlyBold.camera),
                  onPressed: () {
                    //takephoto(ImageSource.camera);
                    pickImagesforCamera();
                  },
                  label: Text("Camera"),
                ),
                const SizedBox(
                  width: 50,
                ),
                TextButton.icon(
                    icon: Icon(IconlyBold.image),
                    onPressed: () {
                      pickImage();
                    },
                    label: Text("Gallery")),
                const SizedBox(
                  width: 50,
                ),
                TextButton.icon(
                    icon: Icon(IconlyBold.delete),
                    onPressed: () async {
                      try {
                        final imageTemp = File("");

                        setState(() => _file = imageTemp);
                      } on PlatformException catch (e) {
                        print(e);
                      }
                      print(_file);
                    },
                    label: Text("Remove")),
              ],
            )
          ],
        ),
      ),
    );
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

  bool showspinner = false;

  Future<void> uploadImage() async {
    setState(() {
      showspinner = true;
    });

    var stream = new http.ByteStream(_file!.openRead());

    stream.cast();
    var length = await _file!.length();

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        Config.baseURL + Config.profilepostapi + "?token=true",
      ),
    );
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      // 'token': token

      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    request.headers['token'] = token;
    request.headers["Content-Type"] = 'multipart/form-data';
    request.fields["first_name"] = firstnametext.text.toString();
    request.fields["last_name"] = lastnamestext.text.toString();
    request.fields["email"] = textemail.text.toString();
    request.fields['gender'] = gendertext.text.toString();
    request.fields['phone'] = phonetext.text.toString();

    var multiport = new http.MultipartFile('profile', stream, length);
    request.files.add(multiport);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showspinner = false;
      });
      print("Succeess fullt");
    } else {
      print("faile");
    }

    if (_file != null) {
      print(_file!.path.split(".").last);
      print("test.${_file!.path.split(".").last}");
      request.files.add(
        http.MultipartFile.fromBytes(
          "profile",
          _file!.readAsBytesSync(),
          filename: "test.${_file!.path.split(".").last}",
          contentType: MediaType("image", "${_file!.path.split(".").last}"),
        ),
      );
    }

    request.send().then((onValue) {
      print(onValue.statusCode);
      print(onValue.reasonPhrase);
      print(onValue.headers);
      print(onValue.contentLength);
    });
  }

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    _file == null
                        ? CachedNetworkImage(
                            imageUrl: profileData.data.profile.toString(),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/istockphoto-1300845620-612x612.jpeg"),
                            ),
                          )
                        : Container(
                            child: Image.file(_file!),
                          ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: SvgPicture.asset(Theme_Settings.CameraIcon),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                firstnametext.text.toString() +
                    " " +
                    lastnamestext.text.toString(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildFirstNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildLastNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "Continue",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    int filelent = _file != null ? await _file!.length() : 0;
                    print("finccc");
                    print(filelent);

                    if (filelent > 0) {
                      var request = http.MultipartRequest(
                          "POST",
                          Uri.parse(Config.baseURL +
                              Config.profilepostapi +
                              "?token=true"));
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String token = pref.getString("loggedIntoken").toString();

                      request.headers["Authorization"] = 'Bearer $token';
                      request.fields["email"] = textemail.text;
                      request.fields["first_name"] = firstnametext.text;
                      request.fields["last_name"] = lastnamestext.text;
                      request.fields["gender"] = gendertext.text;
                      request.fields["phone"] = phonetext.text;

                      var pic = await http.MultipartFile.fromPath(
                          "profile", _file!.path);
                      request.files.add(pic);
                      var response = await request.send();
                      print(response.statusCode);
                      var responseData = await response.stream.toBytes();
                      var responseString = String.fromCharCodes(responseData);
                      print(responseString);
                      if (response.statusCode == 200) {
                        Fluttertoast.showToast(
                            msg: "Your account has been updated successfully.");

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      }
                    } else {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String token = pref.getString("loggedIntoken").toString();
                      var response = await http.post(
                          Uri.parse(Config.baseURL +
                              Config.profilepostapi +
                              "?token=true"),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token',
                            'Accept': 'application/json',
                          },
                          body: jsonEncode({
                            "email": textemail.text.toString(),
                            "first_name": firstnametext.text.toString(),
                            "last_name": lastnamestext.text.toString(),
                            "gender": gendertext.text.toString(),
                            "phone": phonetext.text.toString()
                          }));
                      print(response.statusCode);
                      print(response.body);
                      if (response.statusCode == 200) {
                        Fluttertoast.showToast(
                            msg: "Your account has been updated successfully.");

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ));
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
