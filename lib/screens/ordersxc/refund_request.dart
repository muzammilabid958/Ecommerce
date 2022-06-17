import 'dart:convert';

import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/models/Rating.dart';
import 'package:MakkiHerb/models/orderDetail.dart';
import 'package:MakkiHerb/models/refundRequest.dart';
import 'package:MakkiHerb/screens/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../models/widgetjson.dart';
import '../../size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class RefundRequestScreen extends StatefulWidget {
  int orderNo;
  RefundRequestScreen({
    Key? key,
    required this.orderNo,
  }) : super(key: key);

  @override
  _RefundRequestScreenState createState() => _RefundRequestScreenState(orderNo);
}

class _RefundRequestScreenState extends State<RefundRequestScreen> {
  int tag = 1;
  late double userrating;
  TextEditingController comment = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  String comments = "";
  int orderNo;
  int quantity = 0;
  late RefundRequest refundRequest;
  OrderDetailModel orderDetailModel = OrderDetailModel(
      data: Data(
          id: 0,
          incrementId: "",
          status: "",
          statusLabel: "",
          isGuest: 0,
          customerEmail: "",
          customerFirstName: "",
          customerLastName: "",
          shippingMethod: "",
          shippingTitle: "",
          paymentTitle: "",
          shippingDescription: "",
          isGift: 0,
          totalItemCount: 0,
          totalQtyOrdered: 0,
          grandTotal: "",
          baseGrandTotal: "",
          grandTotalInvoiced: "",
          grandTotalRefunded: "",
          baseGrandTotalRefunded: "",
          subTotal: "",
          baseSubTotal: "",
          subTotalInvoiced: "",
          baseSubTotalInvoiced: "",
          subTotalRefunded: "",
          discountPercent: "",
          discountAmount: "",
          baseDiscountAmount: "",
          discountInvoiced: "",
          baseDiscountInvoiced: "",
          discountRefunded: "",
          baseDiscountRefunded: "",
          taxAmount: "",
          baseTaxAmount: "",
          taxAmountInvoiced: "",
          baseTaxAmountInvoiced: "",
          taxAmountRefunded: "",
          baseTaxAmountRefunded: "",
          shippingAmount: "",
          baseShippingAmount: "",
          shippingInvoiced: "",
          baseShippingInvoiced: "",
          shippingRefunded: "",
          baseShippingRefunded: "",
          customer: Customer(
              id: 0,
              email: "",
              firstName: "",
              lastName: "",
              name: "",
              emailVerified: 0,
              status: 0,
              createdAt: "",
              updatedAt: "",
              gender: '',
              phone: '',
              profile: '',
              dateOfBirth: ''),
          shippingAddress: ShippingAddress(
              id: 0,
              email: "",
              firstName: "",
              lastName: "",
              address1: [""],
              country: "",
              countryName: "",
              state: "",
              city: "",
              postcode: "",
              phone: "",
              createdAt: "",
              updatedAt: ""),
          billingAddress: BillingAddress(
              id: 0,
              email: "",
              firstName: "",
              lastName: "",
              address1: [],
              country: "",
              countryName: "",
              state: "",
              city: "",
              postcode: "",
              phone: "",
              createdAt: "",
              updatedAt: ""),
          items: [],
          shipments: [],
          updatedAt: "",
          createdAt: ""));

  _RefundRequestScreenState(this.orderNo);
  @override
  void initState() {
    // TODO: implement initState
    readJson();

    getOrderDetail(orderNo.toString());
  }

  getOrderDetail(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();
    dynamic data = await APIService.getOrderDetail(token, id);
    print(data);
    setState(() {
      orderDetailModel =
          OrderDetailModel.fromJson(json.decode(json.encode(data)));
    });
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final jsondata = await APIService.jsonfile();

    setState(() {
      getjson = widgetjson.fromJson(jsondata);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [],
        title: Text(
          "Refund ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              "Refund Request",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: orderDetailModel.data.items.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {},
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                        ],
                      ),
                    ),
                    // child: CartCard(cart: cartModel.data.items[index]),

                    child: Row(
                      children: [
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(10)),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                // child: Image.asset(cart.product.images[0]),
                                child: CachedNetworkImage(
                                  imageUrl: orderDetailModel
                                      .data.items[index].product.images[0].url
                                      .toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/images/Placeholders.png'),
                                )),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: Container(
                                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // cart.product.name,
                              orderDetailModel.data.items[index].name
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            SpinBox(
                              value: double.parse(orderDetailModel
                                  .data.items[index].qtyOrdered
                                  .toString()),
                              decoration:
                                  InputDecoration(labelText: 'Quantity'),
                              onChanged: (value) => setState(() {
                                // orderDetailModel.data.items[index].qtyOrdered =
                                //     value.toInt();
                                orderDetailModel.data
                                    .setquantity(value.toInt(), index);
                              }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text.rich(
                              TextSpan(
                                text: orderDetailModel
                                    .data.items[index].formatedPrice
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: Text("Reason"),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: TextFormField(
              controller: comment,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please give your feedback",
                hintStyle: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ),
          Center(
              child: Container(
            margin: EdgeInsets.all(14),
            width: 200,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: HexColor(kPrimaryColor),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () async {
                if (comment.text.isNotEmpty) {
                  print(orderDetailModel.data.items[0].qtyOrdered);
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  String token =
                      preferences.getString("loggedIntoken").toString();
                  List<int> productidd = [];
                  List<int> qty = [];
                  for (var item in orderDetailModel.data.items) {
                    productidd.add(item.id);
                    qty.add(item.qtyOrdered);
                  }

                  //   String jsonList = json.encode(productId);
                  //   print('DSDS');
                  //   print(jsonList);
                  RefundRequest request = RefundRequest(
                      orderNo: orderNo.toString(),
                      reason: comment.text.toString(),
                      productId: productidd,
                      qty: qty);

                  dynamic data = await APIService.RefundedRequest(request);
                  if (data['Message'] == "Refund Request Submited") {
                    Fluttertoast.showToast(msg: data['Message']);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => OrderList()));
                  } else {
                    Fluttertoast.showToast(msg: data['Message']);
                  }
                } else {
                  Fluttertoast.showToast(msg: "Please fill the requirements");
                }
              },
            ),
          ))
        ],
      )),
    );
  }
}
