import 'package:MakkiHerb/screens/category/product_category_screen.dart';
import 'package:MakkiHerb/screens/forgot_password/forgot_password_screen.dart';
import 'package:MakkiHerb/screens/home/components/loader_page.dart';
import 'package:MakkiHerb/screens/serverError.dart';
import 'package:flutter/widgets.dart';
import 'package:MakkiHerb/payment/payment_screen.dart';
import 'package:MakkiHerb/screens/addresslist/address_screen.dart';
import 'package:MakkiHerb/screens/billing_address/billing_address_screen.dart';
import 'package:MakkiHerb/screens/cart/cart_screen.dart';
import 'package:MakkiHerb/screens/category/category_screen.dart';
import 'package:MakkiHerb/screens/complete_profile/complete_profile_screen.dart';
import 'package:MakkiHerb/screens/details/details_screen.dart';
import 'package:MakkiHerb/screens/feature_view/components/featureproduct.dart';
import 'package:MakkiHerb/screens/forgot_password/forgot_password_screen.dart';
import 'package:MakkiHerb/screens/home/components/categories.dart';
import 'package:MakkiHerb/screens/home/home_screen.dart';
import 'package:MakkiHerb/screens/login_success/login_success_screen.dart';
import 'package:MakkiHerb/screens/otp/otp_screen.dart';
import 'package:MakkiHerb/screens/profile/profile_screen.dart';
import 'package:MakkiHerb/screens/complete_profile/components/loader_profile.dart';
import 'package:MakkiHerb/screens/shipment/shipment_screen.dart';
import 'package:MakkiHerb/screens/shipment/shipping_list.dart';
import 'package:MakkiHerb/screens/sign_in/sign_in_screen.dart';
import 'package:MakkiHerb/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  loading_page.routeName: (context) => loading_page(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  Categories.routeName: (context) => Categories(),
  ShipmentScreen.routeName: (context) => ShipmentScreen(),
  // FeatureViewAllProduct.routeName: (context) => FeatureViewAllProduct(),
  billing_address_screen.routeName: (context) => billing_address_screen(),
  AddresslistScreen.routeName: (context) => AddresslistScreen(),
  loading_profile.routeName: (context) => loading_profile(),
  serverError.routeName: (context) => serverError(),
};
