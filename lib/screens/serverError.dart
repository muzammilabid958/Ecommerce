import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/complete_profile/components/loader_profile.dart';
import 'package:MakkiHerb/screens/home/components/icon_btn_with_counter.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/services.dart';

import '../constant/api_services.dart';

class serverError extends StatefulWidget {
  const serverError({Key? key}) : super(key: key);
  static String routeName = "/serverError";

  @override
  State<serverError> createState() => _serverErrorState();
}

class _serverErrorState extends State<serverError> {
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {},
          ),
        ),
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  alignment: Alignment.center,

      // child: LiquidPullToRefresh(
      //     onRefresh: () {
      //       _handleRefresh();
      //       },
      appBar: AppBar(
        title: Text("Error"),
        actions: [
          IconBtnWithCounter(
            svgSrc: "assets/icons/refresh.svg",
            color: "#b88700",
            press: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
        ],
      ),
      //  backgroundColor: Colors.white,
      body: Center(
        child: EmptyWidget(
          image: null,
          packageImage: PackageImage.Image_4,
          title: 'Server Error',
          subTitle: 'Please try again later',
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: Color(0xff9da9c7),
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffabb8d6),
          ),
        ),
      ),
    );
  }
}
