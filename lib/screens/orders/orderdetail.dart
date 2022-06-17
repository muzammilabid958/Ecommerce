// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:MakkiHerb/constants.dart';
import 'package:MakkiHerb/screens/orders/refund_request.dart';
import 'package:MakkiHerb/screens/orders/reviews.dart';
import 'package:MakkiHerb/settings/settings.dart';
import 'package:MakkiHerb/screens/orders/reviews.dart';
import 'package:async_loader/async_loader.dart';
import 'package:MakkiHerb/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/SaveAddress.dart';
import 'package:MakkiHerb/models/orderDetail.dart';
import '../../components/default_button.dart';
import '../../models/widgetjson.dart';
import '../details/components/top_rounded_container.dart';
import 'reviews.dart' as Reviewsss;
import 'package:hexcolor/hexcolor.dart';
import 'package:awesome_loader/awesome_loader.dart';

class OrderDetail extends StatefulWidget {
  String id;
  OrderDetail({Key? key, required this.id}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState(this.id);
}

class _OrderDetailState extends State<OrderDetail> {
  String id;
  late OrderDetailModel orderDetailModel = OrderDetailModel(
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
  _OrderDetailState(this.id);
  StreamController<OrderDetailModel> _streamController = StreamController();
  @override
  void initState() {
    // TODO: implement initState

    Timer.periodic(const Duration(seconds: 2), (timer) {
      getOrderDetail(id);
    });
    readJson();
  }

  getOrderDetail(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("loggedIntoken").toString();
    dynamic data = await APIService.getOrderDetail(token, id);

    setState(() {
      orderDetailModel =
          OrderDetailModel.fromJson(json.decode(json.encode(data)));
    });
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  static const TIMEOUT = const Duration(seconds: 10);

  getMessage() async {
    return Future.delayed(TIMEOUT, () => {});
  }

  widgetjson getjson = widgetjson(banner: []);
  readJson() async {
    final data = await APIService.jsonfile();
    getjson = widgetjson.fromJson(data);
    setState(() {
      getjson = widgetjson.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var _asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: AwesomeLoader(
                  loaderType: AwesomeLoader.AwesomeLoader3,
                  color: HexColor(Theme_Settings.loaderColor['color']),
                ))
          ])),
      renderError: ([error]) => const Text('Something Went Wrong'),
      renderSuccess: ({data}) => SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: const Text(
                  "Ship & Bill to",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),
                )),
            Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Text(
                  orderDetailModel.data.customer.name.toString(),
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Shipping Address '),
                    TextSpan(
                        text: orderDetailModel
                                .data.shippingAddress.address1.isNotEmpty
                            ? orderDetailModel.data.shippingAddress.address1[0]
                                .toString()
                            : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Order no # '),
                    TextSpan(
                        text: orderDetailModel.data.id.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Status '),
                    TextSpan(
                        text: orderDetailModel.data.status.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: orderDetailModel.data.status == 'pending'
                                ? Colors.red
                                : Colors.green)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Payment Method '),
                    TextSpan(
                        text: orderDetailModel.data.paymentTitle.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Shipping Method '),
                    TextSpan(
                        text: orderDetailModel.data.shippingDescription
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Country '),
                    TextSpan(
                        text: orderDetailModel.data.shippingAddress.country
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Total Item Order "),
                    TextSpan(
                        text: orderDetailModel.data.totalItemCount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Total "),
                    TextSpan(
                        text: orderDetailModel.data.grandTotal.isNotEmpty
                            ? orderDetailModel.data.grandTotal
                                .toString()
                                .substring(
                                    0,
                                    orderDetailModel.data.grandTotal
                                        .toString()
                                        .indexOf('.'))
                            : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (orderDetailModel.data.status == "pending") ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    width: 90,
                    child: RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String token =
                            preferences.getString("loggedIntoken").toString();
                        dynamic data = await APIService.CancelOrder(
                            token, orderDetailModel.data.id.toString());
                        Fluttertoast.showToast(msg: data['message']);
                        setState(() {
                          getOrderDetail(id);
                        });
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
                if (orderDetailModel.data.status == "completed") ...[
                  // Container(
                  //   child: NumberInputWithIncrementDecrement(
                  //     controller: TextEditingController(),
                  //     min: 1,
                  //     initialValue: orderDetailModel
                  //         .data.items[index].qtyOrdered,
                  //     max: 3,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.yellow[900],
                      textColor: Colors.white,
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => RefundRequestScreen(
                                  orderNo: orderDetailModel.data.id,
                                )));
                      },
                      child: const Text("Refund"),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Yours item ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: orderDetailModel.data.items.isNotEmpty
                  ? Row(children: [
                      ...List.generate(orderDetailModel.data.items.length,
                          (index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(20)),
                          child: SizedBox(
                            width: getProportionateScreenWidth(140),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 0.9,
                                    child: Container(
                                      width: 100,
                                      margin: const EdgeInsets.all(5),
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(20)),

                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),

                                      child: CachedNetworkImage(
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        imageUrl: orderDetailModel.data
                                            .items[index].product.images[0].url,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: HexColor("#A47E0F"),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/Placeholders.png',
                                        ),
                                      ),
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    orderDetailModel.data.items[index].name
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: HexColor(Theme_Settings
                                                .featureProductListStyle[0]
                                            ['TextColor'])),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity " +
                                            orderDetailModel.data.items[index]
                                                .product.productQty
                                                .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orderDetailModel
                                            .data.items[index].formatedPrice
                                            .toString(),
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.w600,
                                            color: HexColor(getjson
                                                .banner[0].primaryColor)),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.add_comment_rounded),
                                          color: HexColor(
                                              getjson.banner[0].primaryColor),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) => ReviewsScreen(
                                                        productId: int.parse(
                                                            orderDetailModel
                                                                .data
                                                                .items[index]
                                                                .product
                                                                .id
                                                                .toString()))));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ])
                  : const Center(
                      child: Text("No Product Found"),
                    ),
            ),
            Center(
              child: Container(
                width: 150,
                height: 50,
                child: RaisedButton(
                  color: HexColor(getjson.banner.isNotEmpty
                      ? getjson.banner[0].primaryColor
                      : kPrimaryColor),
                  textColor: Colors.white,
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    String token =
                        preferences.getString("loggedIntoken").toString();

                    dynamic data = await APIService.Reorder(
                        token, orderDetailModel.data.id.toString());
                    print(data['message']);
                    Fluttertoast.showToast(msg: data['message'].toString());
                  },
                  child: const Text("Add to Cart"),
                ),
              ),
            )
          ],
        ),
      )),
    );
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          actions: [],
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Order Detail",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _asyncLoader);
  }

  SliverGrid _buildPopularRestaurant() {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return orderDetailModel.data.items.isNotEmpty
              ? GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: getProportionateScreenWidth(140),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(20)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: orderDetailModel
                                      .data.items[index].product.images[0].url,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.green[700],
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/images/Placeholders.png'),
                                ),
                                // ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  orderDetailModel
                                      .data.items[index].product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                      orderDetailModel.data.items[index].product
                                          .formatedPrice
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF212121),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: const Icon(Icons.star),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => ReviewsScreen(
                                                  productId: int.parse(
                                                      orderDetailModel
                                                          .data
                                                          .items[index]
                                                          .product
                                                          .id
                                                          .toString()))));
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }, childCount: orderDetailModel.data.items.length - 1));
  }
}
