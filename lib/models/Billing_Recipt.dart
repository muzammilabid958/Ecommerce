class BillingRecipt {
  BillingRecipt({
    required this.data,
  });
  late final Data data;

  BillingRecipt.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String message;

  Data.fromJson(Map<String, dynamic> json) {
    cart = Cart.fromJson(json['cart']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    this.exchangeRate,
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
    this.conversionTime,
    this.customer,
    this.channel,
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
  late final String customerEmail;
  late final String customerFirstName;
  late final String customerLastName;
  late final String shippingMethod;
  late final Null couponCode;
  late final int isGift;
  late final int itemsCount;
  late final String itemsQty;
  late final Null exchangeRate;
  late final String globalCurrencyCode;
  late final String baseCurrencyCode;
  late final String channelCurrencyCode;
  late final String cartCurrencyCode;
  late final String grandTotal;
  late final String formatedGrandTotal;
  late final String baseGrandTotal;
  late final String formatedBaseGrandTotal;
  late final String subTotal;
  late final String formatedSubTotal;
  late final String baseSubTotal;
  late final String formatedBaseSubTotal;
  late final String taxTotal;
  late final String formatedTaxTotal;
  late final String baseTaxTotal;
  late final String formatedBaseTaxTotal;
  late final String discount;
  late final String formatedDiscount;
  late final String baseDiscount;
  late final String formatedBaseDiscount;
  late final Null checkoutMethod;
  late final int isGuest;
  late final int isActive;
  late final Null conversionTime;
  late final Null customer;
  late final Null channel;
  late final List<Items> items;
  late final SelectedShippingRate selectedShippingRate;
  late final Payment payment;
  late final BillingAddress billingAddress;
  late final ShippingAddress shippingAddress;
  late final String createdAt;
  late final String updatedAt;
  late final String taxes;
  late final String formatedTaxes;
  late final String baseTaxes;
  late final String formatedBaseTaxes;
  late final String formatedDiscountedSubTotal;
  late final String formatedBaseDiscountedSubTotal;

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerEmail = json['customer_email'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    shippingMethod = json['shipping_method'];
    couponCode = null;
    isGift = json['is_gift'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    exchangeRate = null;
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
    conversionTime = null;
    customer = null;
    channel = null;
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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customer_email'] = customerEmail;
    _data['customer_first_name'] = customerFirstName;
    _data['customer_last_name'] = customerLastName;
    _data['shipping_method'] = shippingMethod;
    _data['coupon_code'] = couponCode;
    _data['is_gift'] = isGift;
    _data['items_count'] = itemsCount;
    _data['items_qty'] = itemsQty;
    _data['exchange_rate'] = exchangeRate;
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
    _data['conversion_time'] = conversionTime;
    _data['customer'] = customer;
    _data['channel'] = channel;
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
  late final String sku;
  late final String type;
  late final String name;
  late final String? couponCode;
  late final String weight;
  late final String totalWeight;
  late final String baseTotalWeight;
  late final String price;
  late final String formatedPrice;
  late final String basePrice;
  late final String formatedBasePrice;
  late final Null customPrice;
  late final String formatedCustomPrice;
  late final String total;
  late final String formatedTotal;
  late final String baseTotal;
  late final String formatedBaseTotal;
  late final String taxPercent;
  late final String taxAmount;
  late final String formatedTaxAmount;
  late final String baseTaxAmount;
  late final String formatedBaseTaxAmount;
  late final String discountPercent;
  late final String discountAmount;
  late final String formatedDiscountAmount;
  late final String baseDiscountAmount;
  late final String formatedBaseDiscountAmount;
  late final Additional additional;
  late final Child? child;
  late final Product product;
  late final String createdAt;
  late final String updatedAt;

  Items.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    required this.token,
  });
  late final String productId;
  late final int quantity;
  late final String token;

  Additional.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'].toString();
    quantity = int.parse(json['quantity'].toString());
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    _data['token'] = token;
    return _data;
  }
}

class Child {
  Child({
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
  late final String sku;
  late final String type;
  late final String name;
  late final Null couponCode;
  late final String weight;
  late final String totalWeight;
  late final String baseTotalWeight;
  late final String price;
  late final String formatedPrice;
  late final String basePrice;
  late final String formatedBasePrice;
  late final Null customPrice;
  late final String formatedCustomPrice;
  late final String total;
  late final String formatedTotal;
  late final String baseTotal;
  late final String formatedBaseTotal;
  late final String taxPercent;
  late final String taxAmount;
  late final String formatedTaxAmount;
  late final String baseTaxAmount;
  late final String formatedBaseTaxAmount;
  late final String discountPercent;
  late final String discountAmount;
  late final String formatedDiscountAmount;
  late final String baseDiscountAmount;
  late final String formatedBaseDiscountAmount;
  late final Additional additional;
  late final Null child;
  late final Product product;
  late final String createdAt;
  late final String updatedAt;

  Child.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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

class Product {
  Product({
    required this.id,
    required this.sku,
    required this.type,
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
    required this.Category,
    required this.inStock,
    required this.isSaved,
    required this.isWishlisted,
    required this.isItemInCart,
    required this.showQuantityChanger,
  });
  late final int id;
  late final String sku;
  late final String type;
  late final String name;
  late final String urlKey;
  late final String price;
  late final String formatedPrice;
  late final String shortDescription;
  late final String description;
  late final List<Images> images;
  late final BaseImage baseImage;
  late final String createdAt;
  late final String updatedAt;
  late final List<dynamic> Category;

  late final bool inStock;
  late final bool isSaved;
  late final bool isWishlisted;
  late final bool isItemInCart;
  late final bool showQuantityChanger;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    type = json['type'];
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
    Category = List.castFrom<dynamic, dynamic>(json['Category']);

    inStock = json['in_stock'];
    isSaved = json['is_saved'];
    isWishlisted = json['is_wishlisted'];
    isItemInCart = json['is_item_in_cart'];
    showQuantityChanger = json['show_quantity_changer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sku'] = sku;
    _data['type'] = type;
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
    _data['Category'] = Category;

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
  late final String path;
  late final String url;
  late final String originalImageUrl;
  late final String smallImageUrl;
  late final String mediumImageUrl;
  late final String largeImageUrl;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    url = json['url'];
    originalImageUrl = json['original_image_url'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String smallImageUrl;
  late final String mediumImageUrl;
  late final String largeImageUrl;
  late final String originalImageUrl;

  BaseImage.fromJson(Map<String, dynamic> json) {
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    originalImageUrl = json['original_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['small_image_url'] = smallImageUrl;
    _data['medium_image_url'] = mediumImageUrl;
    _data['large_image_url'] = largeImageUrl;
    _data['original_image_url'] = originalImageUrl;
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
  late final String totalRating;
  late final String averageRating;
  late final String percentage;

  Reviews.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalRating = json['total_rating'];
    averageRating = json['average_rating'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String carrier;
  late final String carrierTitle;
  late final String method;
  late final String methodTitle;
  late final String methodDescription;
  late final int price;
  late final String formatedPrice;
  late final int basePrice;
  late final String formatedBasePrice;
  late final String createdAt;
  late final String updatedAt;

  SelectedShippingRate.fromJson(Map<String, dynamic> json) {
    id = int.parse((json['id'].toString()));
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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String method;
  late final String methodTitle;
  late final String createdAt;
  late final String updatedAt;

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    methodTitle = json['method_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String email;
  late final List<String> address1;
  late final String country;
  late final String countryName;
  late final String state;
  late final String city;
  late final String postcode;
  late final String phone;
  late final String createdAt;
  late final String updatedAt;

  BillingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    address1 = List.castFrom<dynamic, String>(json['address1']);
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String email;
  late final List<String> address1;
  late final String country;
  late final String countryName;
  late final String state;
  late final String city;
  late final String postcode;
  late final String phone;
  late final String createdAt;
  late final String updatedAt;

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    address1 = List.castFrom<dynamic, String>(json['address1']);
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
