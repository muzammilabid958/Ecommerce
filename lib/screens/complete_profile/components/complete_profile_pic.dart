import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
          // ),
          CachedNetworkImage(
            imageUrl:
                'https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg',
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/istockphoto-1300845620-612x612.jpeg"),
            ),
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
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
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
              SizedBox(
                width: 120,
              ),
              TextButton.icon(
                  icon: Icon(IconlyBold.image),
                  onPressed: () {
                    pickImage();
                  },
                  label: Text("Gallery")),
            ],
          )
        ],
      ),
    );
  }
}
