import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 

class loading extends StatefulWidget {
  loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
),
    );
  }
}