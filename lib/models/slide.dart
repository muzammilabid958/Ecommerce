import 'package:flutter/material.dart';

class Slide {
  final String imageURL;

  final String description;

  Slide({required this.imageURL, required this.description});
}

final slidelist = [
  Slide(
      imageURL: 'assets/images/splash_1.png',
      description: '"Welcome , Let’s shop!'),
  Slide(
      imageURL: 'assets/images/splash_2.png',
      description:
          'We help people conect with store \naround Pakistan and UAE'),
  Slide(
      imageURL: 'assets/images/splash_3.png',
      description:
          ' We show the easy way to shop. \nJust stay at home with us'),
];
