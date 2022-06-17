import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:MakkiHerb/models/slide.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
            width: 400,
            child: Image.asset(
              'assets/images/image.png',
              width: 300,
              height: 100,
            )),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
