import 'dart:convert';

import 'package:MakkiHerb/settings/settings.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/components/default_button.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/helper/keyboard.dart';
import 'package:MakkiHerb/models/addressfetch.dart';

import 'package:MakkiHerb/screens/shipment/shipment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/screens/updateshipment/updateshipment_screen.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  List<Data> city = [];
  dynamic ids;
  dynamic get;
  String? _token;
  Fetchaddress address = new Fetchaddress(data: []);
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();

    addressget();
  }

  sharedaddress(int id, String country, String state, String city) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt("id", id);
    preferences.setString("country", country);
    preferences.setString("state", state);
    preferences.setString("city", city);
  }

  addressget() async {
    preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("loggedIntoken").toString();
    String country = preferences.getString("country").toString();
    final res = await http.get(
        Uri.parse(Config.baseURL + Config.addressget + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        });

    if (res.statusCode == 200) {
      dynamic jsonDecoder = json.decode(res.body);

      address = new Fetchaddress.fromJson(jsonDecoder);

      city = address.data;
    }
  }

  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return new Future.delayed(TIMEOUT, () => {});
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getMessage(),
        renderLoad: () => Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: HexColor(Theme_Settings.loaderColor['color']),
                  )
                ])),
        renderError: ([error]) => new Text('Something Went Wrong'),
        renderSuccess: ({data}) => address.data.isEmpty
            ? Center(
                child: Container(
                    width: 200,
                    child: DefaultButton(
                      press: () {
                        Navigator.of(context).pushNamed('/shipment');
                      },
                      text: "Add Address",
                    )))
            : ListView.builder(
                itemCount: address.data.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home),

                            title: Text(
                                address.data[index].address1[0].toString()),
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  textBaseline: TextBaseline.alphabetic,
                                  textDirection: TextDirection.ltr,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text("Country:" +
                                        address.data[index].country.toString()),
                                    Text("State:" +
                                        address.data[index].state.toString()),
                                    Text("ZipCode:" +
                                        address.data[index].postcode
                                            .toString()),
                                    Text("City:" +
                                        address.data[index].city.toString()),
                                    Text("Phone:" +
                                        address.data[index].phone.toString())
                                  ],
                                ),
                              ),
                            ),
                            // Text(address.data[index].country.toString()+"/n"+
                            // address.data[index].state.toString()
                            // ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(width: 8),
                              IconButton(
                                  onPressed: () async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    dynamic data =
                                        await APIService.DeleteAddress(
                                            address.data[index].id.toString(),
                                            preferences
                                                .getString("loggedIntoken")
                                                .toString());

                                    Fluttertoast.showToast(
                                        msg: data['message']);
                                    setState(() {
                                      addressget();
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditShipmentScreen(
                                                    id: address.data[index].id
                                                        .toString())));
// SharedPreferences pref=await SharedPreferences.getInstance();
//    _token=pref.getString("country").toString();
// getprofiledata(address.data[index].country.toString());
                                    //get =sharedaddress(address.data[index].id.toInt(),address.data[index].country.toString() , address.data[index].country.toString(), address.data[index].country.toString());

                                    //                           Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => ShipmentScreen(address.data[index].id.toInt())),
                                    // );
                                  },
                                  icon: Icon(Icons.edit)),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
    return Scaffold(body: _asyncLoader);
  }
}
