import 'dart:convert';
import 'dart:io';

import 'package:MakkiHerb/models/GuestShipingAddress.dart';
import 'package:MakkiHerb/models/refundRequest.dart';
import 'package:MakkiHerb/models/refundRequest.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:MakkiHerb/models/ForgetPasswordUpdate.dart';
import 'package:MakkiHerb/models/Rating.dart';
import 'package:MakkiHerb/models/facebookLogin.dart';
import 'package:MakkiHerb/models/filterid.dart';
import 'package:MakkiHerb/models/forgetPasswordOTP.dart';
import 'package:MakkiHerb/screens/serverError.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:MakkiHerb/constant/config.dart';
import 'package:MakkiHerb/models/AddToCart.dart';
import 'package:MakkiHerb/models/SaveAddress.dart';
import 'package:MakkiHerb/models/ShippingAddress.dart';
import 'package:MakkiHerb/models/payments.dart';
import 'package:MakkiHerb/models/ProfileModel.dart' as ProfileModel;
import 'package:no_context_navigation/no_context_navigation.dart';

import '../models/resendOTP.dart';

import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool loaded_from_firebase = false;

  static String path = "/serverError";
  static FeatureProductListing(String token, String paramter) async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.products + paramter), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print("Feature Product");
    print(response);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static FetaureSeeAll(String flag, String token) async {
    print(Config.baseURL + Config.products + flag);

    String url = "";
    if (token.isEmpty || token.toString() == "null") {
      url = Config.baseURL + Config.products + flag;
    } else {
      url = Config.baseURL + Config.products + flag + "&token=true";

      //    url = Config.baseURL + Config.products + "/" + productid + "&token=true";
    }

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static WishlistItem(String id, String userid, String token) async {
    final response = await http.get(
        Uri.parse(
          Config.baseURL + Config.wishListItemAdd + id + "?token=true",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    print("lets token");
    print(token);
    print(Config.baseURL + Config.wishListItemAdd + id + "?token=true");
    print(response.statusCode);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static ProductDetail(String token, String productid) async {
    String url = "";
    if (token.isEmpty || token.toString() == "null") {
      url = Config.baseURL + Config.products + "/" + productid;
    } else {
      url = Config.baseURL + Config.products + "/" + productid + "&token=true";
    }
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.products + "/" + productid),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static CategoryList(String token) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.categories + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    print(response.request!.url.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static CategoryWiseProduct(String token, String cateId) async {
    final response = await http.get(
        Uri.parse(Config.baseURL +
            Config.products +
            "?token=true&category_id=" +
            cateId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      print("Debug API Data Category Wise");
      print(cateId);
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static AddToCart(
    AddToCartModel addToCartModel,
    String token,
  ) async {
    dynamic data = json.encode(addToCartModel);
    String url = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (token.isEmpty || token.toString() == "null") {
      String cookies = preferences.getString("GuestUserCookies").toString();

      if (cookies.isEmpty || cookies.toString() == "null") {
        url = Config.baseURL + Config.cartAdd + addToCartModel.productId;
        final response = await http.post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: data);

        if (response.statusCode == 200) {
          preferences.setString(
              "GuestUserCookies", response.headers['set-cookie'].toString());

          return jsonDecode(response.body);
        } else if (response.statusCode == 500) {
          navService.pushNamed(path, args: 'From Home Screen');
        } else {
          return jsonDecode(response.body);
        }
      } else {
        print("else state");
        String cookies = preferences.getString("GuestUserCookies").toString();
        print(cookies);
        url = Config.baseURL + Config.cartAdd + addToCartModel.productId;
        final response = await http.post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Cookie': cookies,
            },
            body: data);

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 500) {
          navService.pushNamed(path, args: 'From Home Screen');
        } else {
          return jsonDecode(response.body);
        }
      }
    } else {
      url = Config.baseURL +
          Config.cartAdd +
          addToCartModel.productId +
          "?token=true";

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          body: data);
      print("Add to Cart ");
      print(response.request!.url.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static GetCartItem(String token) async {
    String url = "";

    if (token.isEmpty || token == "") {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String token = preferences.getString("GuestUserCookies").toString();
      print(token);

      final response = await http.get(
        Uri.parse(Config.baseURL + Config.cartget),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': token,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    } else {
      final response = await http.get(
        Uri.parse(Config.baseURL + Config.cartget + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print("Get Cart Product");
      print(response.request!.url.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static GetCartItemGuest(String token) async {
    print("Token" + token);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stoken = preferences.getString("GuestUserCookies").toString();
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.cartget),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': stoken
      },
    );
    print("Get Cart Product");
    print(response.request!.url.toString());
    if (response.statusCode == 200) {
      print("Giser");
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static RemoveFromCart(String token, String id) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.cartRemove + id + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static addToCartUpdate(String token, String productid, String qty) async {
    final response = await http.put(
        Uri.parse(Config.baseURL +
            Config.cartUpdate +
            "?token=true&qty[" +
            productid +
            "]=" +
            qty),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static moveToWishList(String token, String id) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.moveToWishList + id + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static wishListGet(String token) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.wishlist + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static removeToWishList(String token, String id) async {
    final response = await http.delete(
        Uri.parse(Config.baseURL + Config.wishlist + "/" + id + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static addShippingAddress(
    ShippingAdresses shippingAdresses,
    String token,
  ) async {
    dynamic data = json.encode(shippingAdresses);

    if (token.isEmpty || token.toString() == "null") {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String token = preferences.getString("GuestUserCookies").toString();
      print(token);

      final response =
          await http.post(Uri.parse(Config.baseURL + Config.saveAddress),
              headers: {
                'Content-Type': 'application/json',
                'Cookie': token,
                'Accept': 'application/json',
              },
              body: data);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Guest User ");
        print(response.body);
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    } else {
      final response = await http.post(
          Uri.parse(
              Config.baseURL + Config.addressShippingCreate + "?token=true"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          body: data);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static WishlistToCart(String productId, String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL +
          Config.moveWishlistToCart +
          productId +
          "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static getAddress(String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.getAddress + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static getAddressByID(String token, String id) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.getAddress + "/" + id + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static SaveShipping(String shippingmethod, String beartoken) async {
    final jsondata = '{"shipping_method": "' + shippingmethod + '"}';
    String url = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString("GuestUserCookies").toString();
    print(token);

    if (beartoken.isNotEmpty) {
      url = Config.baseURL + Config.saveShipping + "?token=true";
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $beartoken',
            'Accept': 'application/json',
          },
          body: jsondata);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("else statement ");
      url = Config.baseURL + Config.saveShipping;
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': token,
          },
          body: jsondata);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static SavePayment(String loggedInToken, Payments method) async {
    dynamic data = json.encode(method);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (loggedInToken.isEmpty) {
      print("if cd");
      print(data);
      final response =
          await http.post(Uri.parse(Config.baseURL + Config.savePayment),
              headers: {
                'Content-Type': 'application/json',
                'Cookie': preferences.getString("GuestUserCookies").toString(),
                'Accept': 'application/json',
              },
              body: data);

      print(response.request!.url.toString());
      // print("SavePayment Method Request");

      // print(response.request!.url.toString());
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    } else {
      final response = await http.post(
          Uri.parse(Config.baseURL + Config.savePayment + "?token=true"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $loggedInToken',
            'Accept': 'application/json',
          },
          body: data);
      // print("SavePayment Method Request");

      // print(response.request!.url.toString());
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static SaveOrder(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (token.isEmpty || token.toString() == "null") {
      final response = await http.post(
        Uri.parse(Config.baseURL + Config.saveOrder),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': preferences.getString("GuestUserCookies").toString(),
          'Accept': 'application/json',
        },
      );
      // print("Payment Method Request");

      // print(response.request!.url.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    } else {
      final response = await http.post(
        Uri.parse(Config.baseURL + Config.saveOrder + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      // print("Payment Method Request");

      // print(response.request!.url.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        print("500 Error");
        navService.pushNamed(path, args: 'From Home Screen');
      } else {
        return jsonDecode(response.body);
      }
    }
  }

  static SaveAddress(String token, SaveAddresss address) async {
    dynamic data = json.encode(address);
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.saveAddress + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: data);

    if (response.statusCode == 200) {
      // print("Save Adress wali api Response");
      // print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static Logout(String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.customerLogout + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static getOrder(String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.orders + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static getOrderDetail(String token, String id) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.orders + "/" + id + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static customerShipment(String token, String orderid) async {
    final response = await http.get(
      Uri.parse(Config.baseURL +
          Config.customerShippment +
          "?token=true&order_id=" +
          orderid),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static customerProfile(String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.CustomerGet + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print("statudinfg");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static searchProduct(String searchText) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.SearchProduct + searchText),
    );
    // print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static DeleteAddress(String id, String token) async {
    final response = await http.delete(
      Uri.parse(Config.baseURL + Config.addressget + "/" + id + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    // print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static descendantCategories() async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.descendantcategories), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static SubCategories(String? id) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.descendantcategories + id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static HomePageSlider() async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.homePageSlider), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static CarsouelHomePageSlider() async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.homeCarsoursel), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static ForgetPasswordRequest(ForgetEmailOTP email) async {
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.ForgetPasswordRequest),
        body: jsonEncode(email),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static ForgetPasswordOTP(dynamic data) async {
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.ForgetPasswordRequest),
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static VerifyOTP(String email, String otpp) async {
    final response =
        await http.post(Uri.parse(Config.baseURL + Config.forgetVerifyOTP),
            body: ({
              'email': email,
              'otp': otpp,
            }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static UpdateForgetPassword(
      ForgetPasswordUpdateModel forgetPasswordUpdateModel) async {
    dynamic data = json.encode(forgetPasswordUpdateModel);
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.UpdateForgetPassword),
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static FacebookLogin(FacebookLoginModel login) async {
    dynamic data = login.toJson();
    print("Login Json");
    print(data);

    final response = await http.post(
        Uri.parse(Config.baseURL + Config.SocialLogin + "?token=true"),
        body: data);
    print(response.statusCode);
    if (response.statusCode == 406) {
      print("enter in if");
      print(login.toJson().toString());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("facebookloggedData", login.toJson().toString());
      navService.pushNamed('/facebookemail', args: 'From Facebook Screen');
    }
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static GoogleLogin(String email, String displayName) async {
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.googleLogin + "?token=true"),
        body: ({'email': email, 'name': displayName, 'is_social': '1'}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static EditShippingAddress(
    EditShippingAdresses shippingAdresses,
    String token,
  ) async {
    dynamic datajson = shippingAdresses.toJson();
    print(datajson);
    dynamic data = jsonEncode(shippingAdresses);

    final response = await http.put(
        Uri.parse(Config.baseURL +
            Config.getAddress +
            "/" +
            shippingAdresses.id +
            "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: data);

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static Reviews(dynamic comment, String token, String productid) async {
    dynamic data = jsonEncode(comment);
    final response = await http.post(
        Uri.parse(Config.baseURL +
            Config.Reviewsproducts +
            "/" +
            productid +
            "/create?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static Reorder(String token, String orderid) async {
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.Reorder + orderid + "?token=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: json.encode(orderid));

    print(response.request!.url.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static CancelOrder(String token, String orderid) async {
    final response = await http.post(
      Uri.parse(Config.baseURL + Config.orderCancel + orderid + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print(response.request!.url.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static cartEmpty(String token) async {
    final response = await http.get(
      Uri.parse(Config.baseURL + Config.cartEmpty + "?token=true"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static SliderProduct(String cateId) async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.products + cateId), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      print("Debug API Data Category Wise");
      print(cateId);
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static getFilteredProduct(filterid ids) async {
    final response = await http.get(
      Uri.parse(Config.baseURL +
          Config.products +
          "?price=" +
          ids.price +
          "&category_id=" +
          ids.id),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static resendOTP(ResendOTP email) async {
    dynamic json = jsonEncode(email);
    print("Dsds");
    print(json);
    final response = await http.post(Uri.parse(Config.baseURL + Config.otpapi),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static filterPriceRange(String min, String max) async {
    final response = await http.post(
        Uri.parse(
            Config.baseURL + Config.products + "?price=" + min + "," + max),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static GetReviewsByProductID(String? id) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.getReviewbyProductId + id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(Config.baseURL + Config.getReviewbyProductId + id.toString());
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      print(response.statusCode);
    } else {
      return jsonDecode(response.body);
    }
  }

  static GetReviewsByID(String? id) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.ReviewByid + id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      print(response.statusCode);
    } else {
      return jsonDecode(response.body);
    }
  }

  static flashHomePageSlider() async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.homebannerCarsoursel), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static saveAdressAsGuest(
    GuestShippingAdresses shippingAdresses,
  ) async {
    dynamic data = json.encode(shippingAdresses);
    print(data);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString("GuestUserCookies").toString();
    print(token);

    final response =
        await http.post(Uri.parse(Config.baseURL + Config.saveAddress),
            headers: {
              'Content-Type': 'application/json',
              'Cookie': token,
              'Accept': 'application/json',
            },
            body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Guest User ");
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static bannertext() async {
    final response =
        await http.get(Uri.parse(Config.baseURL + Config.bannertext), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print('500 Error');
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static configpages() async {
    final response = await http
        .get(Uri.parse(Config.baseURL + Config.configPages), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print('500 Error');
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static configpagesOnePage(String page) async {
    final response = await http.get(
        Uri.parse(Config.baseURL + Config.configPages + "?filter=" + page),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print('500 Error');
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static jsonfile() async {
    final response =
        await http.get(Uri.parse(Config.baseURL + Config.widgetjson), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print('500 Error');
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static AppleLogin(FacebookLoginModel login) async {
    dynamic data = login.toJson();
    print("api data");
    print(data);
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.SocialLogin + "?token=true"),
        body: data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      print("500 Error");
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }

  static RefundedRequest(RefundRequest refundRequest) async {
    final response = await http.post(
        Uri.parse(Config.baseURL + Config.refundRequest + "?token=true"),
        body: {
          "order_no": refundRequest.orderNo,
          "reason": refundRequest.reason,
          "product_id": '[' + refundRequest.productId.toString() + ']'
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      navService.pushNamed(path, args: 'From Home Screen');
    } else {
      return jsonDecode(response.body);
    }
  }
}
