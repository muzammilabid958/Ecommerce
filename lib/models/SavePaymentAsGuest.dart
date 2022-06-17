class SavePaymentAsGuest {
  SavePaymentAsGuest({
    required this.data,
  });
  late final Data data;

  SavePaymentAsGuest.fromJson(Map<dynamic, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.cart,
    required this.message,
  });
  late final Cart cart;
  late final dynamic message;

  Data.fromJson(Map<dynamic, dynamic> json) {
    cart = Cart.fromJson(json['cart']);
    message = json['message'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['cart'] = cart.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Cart {
  Cart({
    required this.id,
    required this.customerEmail,
    required this.customerFirstName,
    required this.customerLastName,
    required this.shippingMethod,
    this.couponCode,
    required this.isGift,
    required this.itemsCount,
    required this.itemsQty,
    required this.globalCurrencyCode,
    required this.baseCurrencyCode,
    required this.channelCurrencyCode,
    required this.cartCurrencyCode,
    required this.grandTotal,
    required this.formatedGrandTotal,
    required this.baseGrandTotal,
    required this.formatedBaseGrandTotal,
    required this.subTotal,
    required this.formatedSubTotal,
    required this.baseSubTotal,
    required this.formatedBaseSubTotal,
    required this.taxTotal,
    required this.formatedTaxTotal,
    required this.baseTaxTotal,
    required this.formatedBaseTaxTotal,
    required this.discount,
    required this.formatedDiscount,
    required this.baseDiscount,
    required this.formatedBaseDiscount,
    this.checkoutMethod,
    required this.isGuest,
    required this.isActive,
    required this.items,
    required this.selectedShippingRate,
    required this.payment,
    required this.billingAddress,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.taxes,
    required this.formatedTaxes,
    required this.baseTaxes,
    required this.formatedBaseTaxes,
    required this.formatedDiscountedSubTotal,
    required this.formatedBaseDiscountedSubTotal,
  });
  late final int id;
  late final dynamic customerEmail;
  late final dynamic customerFirstName;
  late final dynamic customerLastName;
  late final dynamic shippingMethod;
  late final Null couponCode;
  late final int isGift;
  late final int itemsCount;
  late final dynamic itemsQty;
  late final dynamic globalCurrencyCode;
  late final dynamic baseCurrencyCode;
  late final dynamic channelCurrencyCode;
  late final dynamic cartCurrencyCode;
  late final dynamic grandTotal;
  late final dynamic formatedGrandTotal;
  late final dynamic baseGrandTotal;
  late final dynamic formatedBaseGrandTotal;
  late final dynamic subTotal;
  late final dynamic formatedSubTotal;
  late final dynamic baseSubTotal;
  late final dynamic formatedBaseSubTotal;
  late final dynamic taxTotal;
  late final dynamic formatedTaxTotal;
  late final dynamic baseTaxTotal;
  late final dynamic formatedBaseTaxTotal;
  late final dynamic discount;
  late final dynamic formatedDiscount;
  late final dynamic baseDiscount;
  late final dynamic formatedBaseDiscount;
  late final Null checkoutMethod;
  late final int isGuest;
  late final int isActive;
  late final List<Items> items;
  late final SelectedShippingRate selectedShippingRate;
  late final Payment payment;
  late final BillingAddress billingAddress;
  late final ShippingAddress shippingAddress;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic taxes;
  late final dynamic formatedTaxes;
  late final dynamic baseTaxes;
  late final dynamic formatedBaseTaxes;
  late final dynamic formatedDiscountedSubTotal;
  late final dynamic formatedBaseDiscountedSubTotal;

  Cart.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    customerEmail = json['customer_email'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    shippingMethod = json['shipping_method'];
    couponCode = null;
    isGift = json['is_gift'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    globalCurrencyCode = json['global_currency_code'];
    baseCurrencyCode = json['base_currency_code'];
    channelCurrencyCode = json['channel_currency_code'];
    cartCurrencyCode = json['cart_currency_code'];
    grandTotal = json['grand_total'];
    formatedGrandTotal = json['formated_grand_total'];
    baseGrandTotal = json['base_grand_total'];
    formatedBaseGrandTotal = json['formated_base_grand_total'];
    subTotal = json['sub_total'];
    formatedSubTotal = json['formated_sub_total'];
    baseSubTotal = json['base_sub_total'];
    formatedBaseSubTotal = json['formated_base_sub_total'];
    taxTotal = json['tax_total'];
    formatedTaxTotal = json['formated_tax_total'];
    baseTaxTotal = json['base_tax_total'];
    formatedBaseTaxTotal = json['formated_base_tax_total'];
    discount = json['discount'];
    formatedDiscount = json['formated_discount'];
    baseDiscount = json['base_discount'];
    formatedBaseDiscount = json['formated_base_discount'];
    checkoutMethod = null;
    isGuest = json['is_guest'];
    isActive = json['is_active'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    selectedShippingRate =
        SelectedShippingRate.fromJson(json['selected_shipping_rate']);
    payment = Payment.fromJson(json['payment']);
    billingAddress = BillingAddress.fromJson(json['billing_address']);
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taxes = json['taxes'];
    formatedTaxes = json['formated_taxes'];
    baseTaxes = json['base_taxes'];
    formatedBaseTaxes = json['formated_base_taxes'];
    formatedDiscountedSubTotal = json['formated_discounted_sub_total'];
    formatedBaseDiscountedSubTotal = json['formated_base_discounted_sub_total'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['customer_email'] = customerEmail;
    _data['customer_first_name'] = customerFirstName;
    _data['customer_last_name'] = customerLastName;
    _data['shipping_method'] = shippingMethod;
    _data['coupon_code'] = couponCode;
    _data['is_gift'] = isGift;
    _data['items_count'] = itemsCount;
    _data['items_qty'] = itemsQty;
    _data['global_currency_code'] = globalCurrencyCode;
    _data['base_currency_code'] = baseCurrencyCode;
    _data['channel_currency_code'] = channelCurrencyCode;
    _data['cart_currency_code'] = cartCurrencyCode;
    _data['grand_total'] = grandTotal;
    _data['formated_grand_total'] = formatedGrandTotal;
    _data['base_grand_total'] = baseGrandTotal;
    _data['formated_base_grand_total'] = formatedBaseGrandTotal;
    _data['sub_total'] = subTotal;
    _data['formated_sub_total'] = formatedSubTotal;
    _data['base_sub_total'] = baseSubTotal;
    _data['formated_base_sub_total'] = formatedBaseSubTotal;
    _data['tax_total'] = taxTotal;
    _data['formated_tax_total'] = formatedTaxTotal;
    _data['base_tax_total'] = baseTaxTotal;
    _data['formated_base_tax_total'] = formatedBaseTaxTotal;
    _data['discount'] = discount;
    _data['formated_discount'] = formatedDiscount;
    _data['base_discount'] = baseDiscount;
    _data['formated_base_discount'] = formatedBaseDiscount;
    _data['checkout_method'] = checkoutMethod;
    _data['is_guest'] = isGuest;
    _data['is_active'] = isActive;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['selected_shipping_rate'] = selectedShippingRate.toJson();
    _data['payment'] = payment.toJson();
    _data['billing_address'] = billingAddress.toJson();
    _data['shipping_address'] = shippingAddress.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['taxes'] = taxes;
    _data['formated_taxes'] = formatedTaxes;
    _data['base_taxes'] = baseTaxes;
    _data['formated_base_taxes'] = formatedBaseTaxes;
    _data['formated_discounted_sub_total'] = formatedDiscountedSubTotal;
    _data['formated_base_discounted_sub_total'] =
        formatedBaseDiscountedSubTotal;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.quantity,
    required this.sku,
    required this.type,
    required this.name,
    this.couponCode,
    required this.weight,
    required this.totalWeight,
    required this.baseTotalWeight,
    required this.price,
    required this.formatedPrice,
    required this.basePrice,
    required this.formatedBasePrice,
    this.customPrice,
    required this.formatedCustomPrice,
    required this.total,
    required this.formatedTotal,
    required this.baseTotal,
    required this.formatedBaseTotal,
    required this.taxPercent,
    required this.taxAmount,
    required this.formatedTaxAmount,
    required this.baseTaxAmount,
    required this.formatedBaseTaxAmount,
    required this.discountPercent,
    required this.discountAmount,
    required this.formatedDiscountAmount,
    required this.baseDiscountAmount,
    required this.formatedBaseDiscountAmount,
    required this.additional,
    this.child,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int quantity;
  late final dynamic sku;
  late final dynamic type;
  late final dynamic name;
  late final Null couponCode;
  late final dynamic weight;
  late final dynamic totalWeight;
  late final dynamic baseTotalWeight;
  late final dynamic price;
  late final dynamic formatedPrice;
  late final dynamic basePrice;
  late final dynamic formatedBasePrice;
  late final Null customPrice;
  late final dynamic formatedCustomPrice;
  late final dynamic total;
  late final dynamic formatedTotal;
  late final dynamic baseTotal;
  late final dynamic formatedBaseTotal;
  late final dynamic taxPercent;
  late final dynamic taxAmount;
  late final dynamic formatedTaxAmount;
  late final dynamic baseTaxAmount;
  late final dynamic formatedBaseTaxAmount;
  late final dynamic discountPercent;
  late final dynamic discountAmount;
  late final dynamic formatedDiscountAmount;
  late final dynamic baseDiscountAmount;
  late final dynamic formatedBaseDiscountAmount;
  late final Additional additional;
  late final Null child;
  late final Product product;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  Items.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    sku = json['sku'];
    type = json['type'];
    name = json['name'];
    couponCode = null;
    weight = json['weight'];
    totalWeight = json['total_weight'];
    baseTotalWeight = json['base_total_weight'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    basePrice = json['base_price'];
    formatedBasePrice = json['formated_base_price'];
    customPrice = null;
    formatedCustomPrice = json['formated_custom_price'];
    total = json['total'];
    formatedTotal = json['formated_total'];
    baseTotal = json['base_total'];
    formatedBaseTotal = json['formated_base_total'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    formatedTaxAmount = json['formated_tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    formatedBaseTaxAmount = json['formated_base_tax_amount'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    formatedDiscountAmount = json['formated_discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    formatedBaseDiscountAmount = json['formated_base_discount_amount'];
    additional = Additional.fromJson(json['additional']);
    child = null;
    product = Product.fromJson(json['product']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['quantity'] = quantity;
    _data['sku'] = sku;
    _data['type'] = type;
    _data['name'] = name;
    _data['coupon_code'] = couponCode;
    _data['weight'] = weight;
    _data['total_weight'] = totalWeight;
    _data['base_total_weight'] = baseTotalWeight;
    _data['price'] = price;
    _data['formated_price'] = formatedPrice;
    _data['base_price'] = basePrice;
    _data['formated_base_price'] = formatedBasePrice;
    _data['custom_price'] = customPrice;
    _data['formated_custom_price'] = formatedCustomPrice;
    _data['total'] = total;
    _data['formated_total'] = formatedTotal;
    _data['base_total'] = baseTotal;
    _data['formated_base_total'] = formatedBaseTotal;
    _data['tax_percent'] = taxPercent;
    _data['tax_amount'] = taxAmount;
    _data['formated_tax_amount'] = formatedTaxAmount;
    _data['base_tax_amount'] = baseTaxAmount;
    _data['formated_base_tax_amount'] = formatedBaseTaxAmount;
    _data['discount_percent'] = discountPercent;
    _data['discount_amount'] = discountAmount;
    _data['formated_discount_amount'] = formatedDiscountAmount;
    _data['base_discount_amount'] = baseDiscountAmount;
    _data['formated_base_discount_amount'] = formatedBaseDiscountAmount;
    _data['additional'] = additional.toJson();
    _data['child'] = child;
    _data['product'] = product.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Additional {
  Additional({
    required this.productId,
    required this.quantity,
  });
  late final dynamic productId;
  late final int quantity;

  Additional.fromJson(Map<dynamic, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.urlKey,
    required this.price,
    required this.formatedPrice,
    required this.shortDescription,
    required this.description,
    required this.images,
    required this.baseImage,
    required this.createdAt,
    required this.updatedAt,
    required this.productQty,
    // required this.Category,
    required this.reviews,
    required this.inStock,
    required this.isSaved,
    required this.isWishlisted,
    required this.isItemInCart,
    required this.showQuantityChanger,
  });
  late final int id;
  late final dynamic sku;
  late final dynamic name;
  late final dynamic urlKey;
  late final dynamic price;
  late final dynamic formatedPrice;
  late final dynamic shortDescription;
  late final dynamic description;
  late final List<Images> images;
  late final BaseImage baseImage;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final int productQty;
  // late final List<Category> Category;
  late final Reviews reviews;
  late final bool inStock;
  late final bool isSaved;
  late final bool isWishlisted;
  late final bool isItemInCart;
  late final bool showQuantityChanger;

  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    urlKey = json['url_key'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    shortDescription = json['short_description'];
    description = json['description'];
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    baseImage = BaseImage.fromJson(json['base_image']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productQty = json['product_qty'];
    // Category =
    //     List.from(json['Category']).map((e) => Category.fromJson(e)).toList();
    reviews = Reviews.fromJson(json['reviews']);
    inStock = json['in_stock'];
    isSaved = json['is_saved'];
    isWishlisted = json['is_wishlisted'];
    isItemInCart = json['is_item_in_cart'];
    showQuantityChanger = json['show_quantity_changer'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['sku'] = sku;
    _data['name'] = name;
    _data['url_key'] = urlKey;
    _data['price'] = price;
    _data['formated_price'] = formatedPrice;
    _data['short_description'] = shortDescription;
    _data['description'] = description;
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['base_image'] = baseImage.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['product_qty'] = productQty;
    // _data['Category'] = Category.map((e) => e.toJson()).toList();
    _data['reviews'] = reviews.toJson();
    _data['in_stock'] = inStock;
    _data['is_saved'] = isSaved;
    _data['is_wishlisted'] = isWishlisted;
    _data['is_item_in_cart'] = isItemInCart;
    _data['show_quantity_changer'] = showQuantityChanger;
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.path,
    required this.url,
    required this.originalImageUrl,
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.largeImageUrl,
  });
  late final int id;
  late final dynamic path;
  late final dynamic url;
  late final dynamic originalImageUrl;
  late final dynamic smallImageUrl;
  late final dynamic mediumImageUrl;
  late final dynamic largeImageUrl;

  Images.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    path = json['path'];
    url = json['url'];
    originalImageUrl = json['original_image_url'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['path'] = path;
    _data['url'] = url;
    _data['original_image_url'] = originalImageUrl;
    _data['small_image_url'] = smallImageUrl;
    _data['medium_image_url'] = mediumImageUrl;
    _data['large_image_url'] = largeImageUrl;
    return _data;
  }
}

class BaseImage {
  BaseImage({
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.largeImageUrl,
    required this.originalImageUrl,
  });
  late final dynamic smallImageUrl;
  late final dynamic mediumImageUrl;
  late final dynamic largeImageUrl;
  late final dynamic originalImageUrl;

  BaseImage.fromJson(Map<dynamic, dynamic> json) {
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    originalImageUrl = json['original_image_url'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['small_image_url'] = smallImageUrl;
    _data['medium_image_url'] = mediumImageUrl;
    _data['large_image_url'] = largeImageUrl;
    _data['original_image_url'] = originalImageUrl;
    return _data;
  }
}

class Category {
  Category({
    required this.name,
  });
  late final dynamic name;

  Category.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}

class Reviews {
  Reviews({
    required this.total,
    required this.totalRating,
    required this.averageRating,
    required this.percentage,
  });
  late final int total;
  late final dynamic totalRating;
  late final dynamic averageRating;
  late final dynamic percentage;

  Reviews.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    totalRating = json['total_rating'];
    averageRating = json['average_rating'];
    percentage = json['percentage'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['total'] = total;
    _data['total_rating'] = totalRating;
    _data['average_rating'] = averageRating;
    _data['percentage'] = percentage;
    return _data;
  }
}

class SelectedShippingRate {
  SelectedShippingRate({
    required this.id,
    required this.carrier,
    required this.carrierTitle,
    required this.method,
    required this.methodTitle,
    required this.methodDescription,
    required this.price,
    required this.formatedPrice,
    required this.basePrice,
    required this.formatedBasePrice,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final dynamic carrier;
  late final dynamic carrierTitle;
  late final dynamic method;
  late final dynamic methodTitle;
  late final dynamic methodDescription;
  late final int price;
  late final dynamic formatedPrice;
  late final int basePrice;
  late final dynamic formatedBasePrice;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  SelectedShippingRate.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    carrier = json['carrier'];
    carrierTitle = json['carrier_title'];
    method = json['method'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    basePrice = json['base_price'];
    formatedBasePrice = json['formated_base_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['carrier'] = carrier;
    _data['carrier_title'] = carrierTitle;
    _data['method'] = method;
    _data['method_title'] = methodTitle;
    _data['method_description'] = methodDescription;
    _data['price'] = price;
    _data['formated_price'] = formatedPrice;
    _data['base_price'] = basePrice;
    _data['formated_base_price'] = formatedBasePrice;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Payment {
  Payment({
    required this.id,
    required this.method,
    required this.methodTitle,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final dynamic method;
  late final dynamic methodTitle;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  Payment.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    method = json['method'];
    methodTitle = json['method_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['method'] = method;
    _data['method_title'] = methodTitle;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class BillingAddress {
  BillingAddress({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.address1,
    required this.country,
    required this.countryName,
    required this.state,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final dynamic firstName;
  late final dynamic lastName;
  late final dynamic name;
  late final dynamic email;
  late final List<dynamic> address1;
  late final dynamic country;
  late final dynamic countryName;
  late final dynamic state;
  late final dynamic city;
  late final dynamic postcode;
  late final dynamic phone;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  BillingAddress.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    address1 = List.castFrom<dynamic, dynamic>(json['address1']);
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['name'] = name;
    _data['email'] = email;
    _data['address1'] = address1;
    _data['country'] = country;
    _data['country_name'] = countryName;
    _data['state'] = state;
    _data['city'] = city;
    _data['postcode'] = postcode;
    _data['phone'] = phone;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.address1,
    required this.country,
    required this.countryName,
    required this.state,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final dynamic firstName;
  late final dynamic lastName;
  late final dynamic name;
  late final dynamic email;
  late final List<dynamic> address1;
  late final dynamic country;
  late final dynamic countryName;
  late final dynamic state;
  late final dynamic city;
  late final dynamic postcode;
  late final dynamic phone;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  ShippingAddress.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    address1 = List.castFrom<dynamic, dynamic>(json['address1']);
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['name'] = name;
    _data['email'] = email;
    _data['address1'] = address1;
    _data['country'] = country;
    _data['country_name'] = countryName;
    _data['state'] = state;
    _data['city'] = city;
    _data['postcode'] = postcode;
    _data['phone'] = phone;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
