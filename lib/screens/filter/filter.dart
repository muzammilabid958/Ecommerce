import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Categories.dart';
import 'package:MakkiHerb/models/widgetjson.dart';
import 'package:MakkiHerb/screens/filter/showFilterResult.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async_loader/async_loader.dart';
import 'package:MakkiHerb/models/Categories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_loader/awesome_loader.dart';
import '../../models/DescendantCategory.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class FilterPage extends StatefulWidget {
  String cate;
  FilterPage({Key? key, required this.cate}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState(this.cate);
}

class _FilterPageState extends State<FilterPage> {
  late DescendantCategory results;
  late DescendantCategory categories = DescendantCategory(
    data: [],
  );
  String cate;
  _FilterPageState(this.cate);
  getCategoryData(String cate) async {
    print("dsdsds");
    dynamic data = await APIService.SubCategories(cate);
    print(data);
    categories = DescendantCategory.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData(cate);
    readJson();
  }

  double _lowerValue = 0;
  double _upperValue = 0;

  List _selecteCategorys = [];
  void _onCategorySelected(bool selected, category_id) async {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setString(
      //     'categoryFilterArray', _selecteCategorys.toString());
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);
  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  RangeValues _currentRangeValues = const RangeValues(40, 80);
  List<String> selectedid = [];
  List<String> selectedids = [];
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: HexColor(Theme_Settings.loaderColor['color']),
            )),
        renderSuccess: ({data}) => categories.data.length > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text(
                                      "Price",
                                    )),
                              ]),
                          // FlutterSlider(
                          //   values: [80, 320],
                          //   rangeSlider: true,
                          //   max: 1600,
                          //   min: 10,
                          //   onDragging: (handlerIndex, lowerValue, upperValue) {
                          //     _lowerValue = lowerValue;
                          //     _upperValue = upperValue;
                          //     this.setState(() {});
                          //     print(_lowerValue);
                          //     print(_upperValue);
                          //   },
                          // ),
                          RangeSlider(
                            values: _currentRangeValues,
                            max: 16000,
                            divisions: 25,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                          for (var item in categories.data) ...{
                            CheckboxListTile(
                              title: Text(item.name.toString()),
                              selected: _value,
                              value: _selecteCategorys.contains(item.id),
                              onChanged: (bool? selected) {
                                int searchindex =
                                    selectedid.indexOf(item.id.toString());

                                if (selected == true) {
                                  selectedid.add(item.id.toString());
                                } else {
                                  selectedid.remove(selectedid[searchindex]);
                                }

                                _onCategorySelected(selected!, item.id);
                              },
                            ),
                          }
                        ]))
                  ])
            : Center(
                child: Text("No Subcategory Found"),
              ));

    return Scaffold(
      floatingActionButton: new Container(
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: FloatingActionButton(
            // backgroundColor:
            //     selectedid.length > 0 ? HexColor(getjson.banner[0].primaryColor) : Colors.grey,
            backgroundColor: HexColor(getjson.banner.isNotEmpty
                ? getjson.banner[0].primaryColor
                : kPrimaryColor),
            onPressed: () {
              // print(selectedid);
              // if (selectedid.length > 0) {
              if (_currentRangeValues.start == 0 &&
                  _currentRangeValues.end == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowFilterData(
                            id: selectedid,
                            price: [],
                          )),
                );
              } else {
                print("Else Statement ");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowFilterData(
                            id: selectedid,
                            price: [
                              _currentRangeValues.start.toString(),
                              _currentRangeValues.end.toString()
                            ],
                          )),
                );
              }
              // }
            },
            child: const Icon(Icons.check),
          )),
      appBar: AppBar(
        title: Text(
          "Select Filter",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _asyncLoader,
    );
  }
}
