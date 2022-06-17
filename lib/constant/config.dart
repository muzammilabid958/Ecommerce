class Config {
  static const String appname = "Makki Herbals";

  static const String baseURL =
      "https://shop.makkiherbals.com/Admin/public/api/";
  //"http://shop.irishandbags.com/public/api/api/";
  static const String imageBaseURL =
      "https://shop.makkiherbals.com/Admin/public/api/";
  //"http://shop.irishandbags.com/public/api/";
  static const String loginapi = "customer/login";
  static const String registerapi =
      "https://shop.makkiherbals.com/Admin/public/api/customer/register";
  static const String logoutapi =
      "https://shop.makkiherbals.com/Admin/public/api/customer/logout";
  static const String profilegetapi = "customer/get";
  static const String profilepostapi = "customer/profile";
  static const String otpapi = "customer/request_otp";
  static const String validateotp = "customer/verify_otp";

  static const String products = "products";
  static const String categories = "categories";

  static const String featureproducts = "?featured=1";
  static const String featureproductsLimit = "&limit=";

  static const String wishListItemAdd = "wishlist/add/";
  static const String wishListCustomerID = "?customer_id=";
  static const String cartAdd = "checkout/cart/add/";
  static const String cartget = "checkout/cart";
  static const String cartRemove = "checkout/cart/remove-item/";
  static const String cartUpdate = "checkout/cart/update";
  static const String moveToWishList = "checkout/cart/move-to-wishlist/";
  static const String wishlist = "wishlist";

  static const String addressShippingCreate = "addresses/create";

  static const String homebannerCarsoursel = "sliders?slider_for=banner";
  static const String moveWishlistToCart = "move-to-cart/";
  static const String getAddress = "addresses";
  static const String savePayment = "checkout/save-payment";
  static const String saveOrder = "checkout/save-order";

  static const String saveAddress = "checkout/save-address";

  static const String saveShipping = "checkout/save-shipping";

  static const String customerLogout = "customer/logout";

  static const String orders = "orders";

  static const String addressget = "addresses";
  static const String customerShippment = "shipments";

  static const String CustomerGet = "customer/get";

  static const String SearchProduct = "search/";

  static const String couponpost = "checkout/cart/coupon";

  static const String descendantcategories = "descendant-categories?parent_id=";
  static const String homePageSlider = "sliders?slider_for=mobile";
  static const String homeCarsoursel = "sliders?slider_for=mobile_banner";

  static const String changepassword = "customer/changepassword";

  static const String ForgetPasswordRequest = "customer/forget_get_email";

  static const String forgetVerifyOTP = "customer/forget_verify_otp";

  static const String UpdateForgetPassword = "customer/forget_password_update";

  static const String SocialLogin = "customer/login-social-fb";
  static const String googleLogin = "customer/login-social-google";
  static const String Reviewsproducts = "reviews";
  static const String Reorder = "checkout/re-order/";
  static const String orderCancel = "checkout/order-cancel/";
  static const String cartEmpty = "checkout/cart/empty";
  static const String filteredcategoryProduct = "filter-category-product";
  static const String getReviewbyProductId = "reviews?product_id=";

  static const String ReviewByid = "reviews/";
  static const String bannertext = 'main-screen-text';
  static const String configPages = 'get-config-pages';
  static const String widgetjson = 'json';
  static const String refundRequest = 'refund-request';
}
