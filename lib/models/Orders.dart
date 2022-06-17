class Orders {
  Orders({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<Data> data;
  late final Links links;
  late final Meta meta;

  Orders.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.incrementId,
    required this.status,
    required this.statusLabel,
    required this.isGuest,
    required this.customerEmail,
    required this.customerFirstName,
    required this.customerLastName,
    required this.shippingMethod,
    required this.shippingTitle,
    required this.paymentTitle,
    required this.shippingDescription,
    this.couponCode,
    required this.isGift,
    required this.totalItemCount,
    required this.totalQtyOrdered,
    required this.grandTotal,
    required this.baseGrandTotal,
    required this.grandTotalInvoiced,
    required this.grandTotalRefunded,
    required this.baseGrandTotalRefunded,
    required this.subTotal,
    required this.baseSubTotal,
    required this.subTotalInvoiced,
    required this.baseSubTotalInvoiced,
    required this.subTotalRefunded,
    required this.discountPercent,
    required this.discountAmount,
    required this.baseDiscountAmount,
    required this.discountInvoiced,
    required this.baseDiscountInvoiced,
    required this.discountRefunded,
    required this.baseDiscountRefunded,
    required this.taxAmount,
    required this.baseTaxAmount,
    required this.taxAmountInvoiced,
    required this.baseTaxAmountInvoiced,
    required this.taxAmountRefunded,
    required this.baseTaxAmountRefunded,
    required this.shippingAmount,
    required this.baseShippingAmount,
    required this.shippingInvoiced,
    required this.baseShippingInvoiced,
    required this.shippingRefunded,
    required this.baseShippingRefunded,
    required this.customer,
    required this.shippingAddress,
    required this.billingAddress,
    required this.items,
    required this.shipments,
    required this.updatedAt,
    required this.createdAt,
  });
  late final int id;
  late final String incrementId;
  late final String status;
  late final String statusLabel;
  late final int isGuest;
  late final String customerEmail;
  late final String customerFirstName;
  late final String customerLastName;
  late final String shippingMethod;
  late final String shippingTitle;
  late final String paymentTitle;
  late final String shippingDescription;
  late final Null couponCode;
  late final int isGift;
  late final int totalItemCount;
  late final int totalQtyOrdered;
  late final String grandTotal;
  late final String baseGrandTotal;
  late final String grandTotalInvoiced;
  late final String grandTotalRefunded;
  late final String baseGrandTotalRefunded;
  late final String subTotal;
  late final String baseSubTotal;
  late final String subTotalInvoiced;
  late final String baseSubTotalInvoiced;
  late final String subTotalRefunded;
  late final String discountPercent;
  late final String discountAmount;
  late final String baseDiscountAmount;
  late final String discountInvoiced;
  late final String baseDiscountInvoiced;
  late final String discountRefunded;
  late final String baseDiscountRefunded;
  late final String taxAmount;
  late final String baseTaxAmount;
  late final String taxAmountInvoiced;
  late final String baseTaxAmountInvoiced;
  late final String taxAmountRefunded;
  late final String baseTaxAmountRefunded;
  late final String shippingAmount;
  late final String baseShippingAmount;
  late final String shippingInvoiced;
  late final String baseShippingInvoiced;
  late final String shippingRefunded;
  late final String baseShippingRefunded;
  late final Customer customer;
  late final ShippingAddress shippingAddress;
  late final BillingAddress billingAddress;
  late final List<Items> items;
  late final List<dynamic> shipments;
  late final String updatedAt;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    incrementId = json['increment_id'];
    status = json['status'];
    statusLabel = json['status_label'];
    isGuest = json['is_guest'];
    customerEmail = json['customer_email'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    shippingMethod = json['shipping_method'];
    shippingTitle = json['shipping_title'];
    paymentTitle = json['payment_title'];
    shippingDescription = json['shipping_description'];
    couponCode = null;
    isGift = json['is_gift'];
    totalItemCount = json['total_item_count'];
    totalQtyOrdered = json['total_qty_ordered'];
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    grandTotalInvoiced = json['grand_total_invoiced'];
    grandTotalRefunded = json['grand_total_refunded'];
    baseGrandTotalRefunded = json['base_grand_total_refunded'];
    subTotal = json['sub_total'];
    baseSubTotal = json['base_sub_total'];
    subTotalInvoiced = json['sub_total_invoiced'];
    baseSubTotalInvoiced = json['base_sub_total_invoiced'];
    subTotalRefunded = json['sub_total_refunded'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    discountRefunded = json['discount_refunded'];
    baseDiscountRefunded = json['base_discount_refunded'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxAmountInvoiced = json['tax_amount_invoiced'];
    baseTaxAmountInvoiced = json['base_tax_amount_invoiced'];
    taxAmountRefunded = json['tax_amount_refunded'];
    baseTaxAmountRefunded = json['base_tax_amount_refunded'];
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingInvoiced = json['shipping_invoiced'];
    baseShippingInvoiced = json['base_shipping_invoiced'];
    shippingRefunded = json['shipping_refunded'];
    baseShippingRefunded = json['base_shipping_refunded'];
    customer = Customer.fromJson(json['customer']);
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
    billingAddress = BillingAddress.fromJson(json['billing_address']);
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    shipments = List.castFrom<dynamic, dynamic>(json['shipments']);
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['increment_id'] = incrementId;
    _data['status'] = status;
    _data['status_label'] = statusLabel;
    _data['is_guest'] = isGuest;
    _data['customer_email'] = customerEmail;
    _data['customer_first_name'] = customerFirstName;
    _data['customer_last_name'] = customerLastName;
    _data['shipping_method'] = shippingMethod;
    _data['shipping_title'] = shippingTitle;
    _data['payment_title'] = paymentTitle;
    _data['shipping_description'] = shippingDescription;
    _data['coupon_code'] = couponCode;
    _data['is_gift'] = isGift;
    _data['total_item_count'] = totalItemCount;
    _data['total_qty_ordered'] = totalQtyOrdered;
    _data['grand_total'] = grandTotal;
    _data['base_grand_total'] = baseGrandTotal;
    _data['grand_total_invoiced'] = grandTotalInvoiced;
    _data['grand_total_refunded'] = grandTotalRefunded;
    _data['base_grand_total_refunded'] = baseGrandTotalRefunded;
    _data['sub_total'] = subTotal;
    _data['base_sub_total'] = baseSubTotal;
    _data['sub_total_invoiced'] = subTotalInvoiced;
    _data['base_sub_total_invoiced'] = baseSubTotalInvoiced;
    _data['sub_total_refunded'] = subTotalRefunded;
    _data['discount_percent'] = discountPercent;
    _data['discount_amount'] = discountAmount;
    _data['base_discount_amount'] = baseDiscountAmount;
    _data['discount_invoiced'] = discountInvoiced;
    _data['base_discount_invoiced'] = baseDiscountInvoiced;
    _data['discount_refunded'] = discountRefunded;
    _data['base_discount_refunded'] = baseDiscountRefunded;
    _data['tax_amount'] = taxAmount;
    _data['base_tax_amount'] = baseTaxAmount;
    _data['tax_amount_invoiced'] = taxAmountInvoiced;
    _data['base_tax_amount_invoiced'] = baseTaxAmountInvoiced;
    _data['tax_amount_refunded'] = taxAmountRefunded;
    _data['base_tax_amount_refunded'] = baseTaxAmountRefunded;
    _data['shipping_amount'] = shippingAmount;
    _data['base_shipping_amount'] = baseShippingAmount;
    _data['shipping_invoiced'] = shippingInvoiced;
    _data['base_shipping_invoiced'] = baseShippingInvoiced;
    _data['shipping_refunded'] = shippingRefunded;
    _data['base_shipping_refunded'] = baseShippingRefunded;
    _data['customer'] = customer.toJson();
    _data['shipping_address'] = shippingAddress.toJson();
    _data['billing_address'] = billingAddress.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['shipments'] = shipments;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}

class Customer {
  Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.profile,
    required this.emailVerified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final Null gender;
  late final Null dateOfBirth;
  late final Null phone;
  late final Null profile;
  late final int emailVerified;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    gender = null;
    dateOfBirth = null;
    phone = null;
    profile = null;
    emailVerified = json['email_verified'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['name'] = name;
    _data['gender'] = gender;
    _data['date_of_birth'] = dateOfBirth;
    _data['phone'] = phone;
    _data['profile'] = profile;
    _data['email_verified'] = emailVerified;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
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
  late final String email;
  late final String firstName;
  late final String lastName;
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
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
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

class BillingAddress {
  BillingAddress({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
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
  late final String email;
  late final String firstName;
  late final String lastName;
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
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
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

class Items {
  Items({
    required this.id,
    required this.sku,
    required this.name,
    required this.product,
    this.couponCode,
    required this.weight,
    required this.totalWeight,
    required this.qtyOrdered,
    required this.qtyCanceled,
    required this.qtyInvoiced,
    required this.qtyShipped,
    required this.qtyRefunded,
    required this.price,
    required this.formatedPrice,
    required this.basePrice,
    required this.formatedBasePrice,
    required this.total,
    required this.baseTotal,
    required this.totalInvoiced,
    required this.baseTotalInvoiced,
    required this.amountRefunded,
    required this.formatedAmountRefunded,
    required this.baseAmountRefunded,
    required this.formatedBaseAmountRefunded,
    required this.discountPercent,
    required this.discountAmount,
    required this.baseDiscountAmount,
    required this.discountInvoiced,
    required this.formatedDiscountInvoiced,
    required this.baseDiscountInvoiced,
    required this.discountRefunded,
    required this.baseDiscountRefunded,
    required this.taxPercent,
    required this.taxAmount,
    required this.baseTaxAmount,
    required this.taxAmountInvoiced,
    required this.baseTaxAmountInvoiced,
    required this.taxAmountRefunded,
    required this.baseTaxAmountRefunded,
    required this.grantTotal,
    required this.baseGrantTotal,
    required this.additional,
  });
  late final int id;
  late final String sku;
  late final String name;
  late final Product product;
  late final Null couponCode;
  late final String weight;
  late final String totalWeight;
  late final int qtyOrdered;
  late final int qtyCanceled;
  late final int qtyInvoiced;
  late final int qtyShipped;
  late final int qtyRefunded;
  late final String price;
  late final String formatedPrice;
  late final String basePrice;
  late final String formatedBasePrice;
  late final String total;
  late final String baseTotal;
  late final String totalInvoiced;
  late final String baseTotalInvoiced;
  late final String amountRefunded;
  late final String formatedAmountRefunded;
  late final String baseAmountRefunded;
  late final String formatedBaseAmountRefunded;
  late final String discountPercent;
  late final String discountAmount;
  late final String baseDiscountAmount;
  late final String discountInvoiced;
  late final String formatedDiscountInvoiced;
  late final String baseDiscountInvoiced;
  late final String discountRefunded;
  late final String baseDiscountRefunded;
  late final String taxPercent;
  late final String taxAmount;
  late final String baseTaxAmount;
  late final String taxAmountInvoiced;
  late final String baseTaxAmountInvoiced;
  late final String taxAmountRefunded;
  late final String baseTaxAmountRefunded;
  late final int grantTotal;
  late final int baseGrantTotal;
  late final Additional additional;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    product = Product.fromJson(json['product']);
    couponCode = null;
    weight = json['weight'];
    totalWeight = json['total_weight'];
    qtyOrdered = json['qty_ordered'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyShipped = json['qty_shipped'];
    qtyRefunded = json['qty_refunded'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    basePrice = json['base_price'];
    formatedBasePrice = json['formated_base_price'];
    total = json['total'];
    baseTotal = json['base_total'];
    totalInvoiced = json['total_invoiced'];
    baseTotalInvoiced = json['base_total_invoiced'];
    amountRefunded = json['amount_refunded'];
    formatedAmountRefunded = json['formated_amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    formatedBaseAmountRefunded = json['formated_base_amount_refunded'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    formatedDiscountInvoiced = json['formated_discount_invoiced'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    discountRefunded = json['discount_refunded'];
    baseDiscountRefunded = json['base_discount_refunded'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxAmountInvoiced = json['tax_amount_invoiced'];
    baseTaxAmountInvoiced = json['base_tax_amount_invoiced'];
    taxAmountRefunded = json['tax_amount_refunded'];
    baseTaxAmountRefunded = json['base_tax_amount_refunded'];
    grantTotal = json['grant_total'];
    baseGrantTotal = json['base_grant_total'];
    additional = Additional.fromJson(json['additional']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sku'] = sku;
    _data['name'] = name;
    _data['product'] = product.toJson();
    _data['coupon_code'] = couponCode;
    _data['weight'] = weight;
    _data['total_weight'] = totalWeight;
    _data['qty_ordered'] = qtyOrdered;
    _data['qty_canceled'] = qtyCanceled;
    _data['qty_invoiced'] = qtyInvoiced;
    _data['qty_shipped'] = qtyShipped;
    _data['qty_refunded'] = qtyRefunded;
    _data['price'] = price;
    _data['formated_price'] = formatedPrice;
    _data['base_price'] = basePrice;
    _data['formated_base_price'] = formatedBasePrice;
    _data['total'] = total;
    _data['base_total'] = baseTotal;
    _data['total_invoiced'] = totalInvoiced;
    _data['base_total_invoiced'] = baseTotalInvoiced;
    _data['amount_refunded'] = amountRefunded;
    _data['formated_amount_refunded'] = formatedAmountRefunded;
    _data['base_amount_refunded'] = baseAmountRefunded;
    _data['formated_base_amount_refunded'] = formatedBaseAmountRefunded;
    _data['discount_percent'] = discountPercent;
    _data['discount_amount'] = discountAmount;
    _data['base_discount_amount'] = baseDiscountAmount;
    _data['discount_invoiced'] = discountInvoiced;
    _data['formated_discount_invoiced'] = formatedDiscountInvoiced;
    _data['base_discount_invoiced'] = baseDiscountInvoiced;
    _data['discount_refunded'] = discountRefunded;
    _data['base_discount_refunded'] = baseDiscountRefunded;
    _data['tax_percent'] = taxPercent;
    _data['tax_amount'] = taxAmount;
    _data['base_tax_amount'] = baseTaxAmount;
    _data['tax_amount_invoiced'] = taxAmountInvoiced;
    _data['base_tax_amount_invoiced'] = baseTaxAmountInvoiced;
    _data['tax_amount_refunded'] = taxAmountRefunded;
    _data['base_tax_amount_refunded'] = baseTaxAmountRefunded;
    _data['grant_total'] = grantTotal;
    _data['base_grant_total'] = baseGrantTotal;
    _data['additional'] = additional.toJson();
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
    // required this.Category,
    required this.reviews,
    required this.inStock,
    required this.isSaved,
    required this.isWishlisted,
    required this.isItemInCart,
    required this.showQuantityChanger,
    required this.specialPrice,
    required this.formatedSpecialPrice,
    required this.regularPrice,
    required this.formatedRegularPrice,
  });
  late final int id;
  late final String sku;
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
  // late final List<Category> Category;
  late final Reviews reviews;
  late final bool inStock;
  late final bool isSaved;
  late final bool isWishlisted;
  late final bool isItemInCart;
  late final bool showQuantityChanger;
  late final String specialPrice;
  late final String formatedSpecialPrice;
  late final int regularPrice;
  late final String formatedRegularPrice;

  Product.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['id'];
      sku = json['sku'];
      name = json['name'];
      urlKey = json['url_key'];
      price = json['price'];
      formatedPrice = json['formated_price'];
      shortDescription = json['short_description'];
      description = json['description'];
      images =
          List.from(json['images']).map((e) => Images.fromJson(e)).toList();
      baseImage = BaseImage.fromJson(json['base_image']);
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      // Category =
      //     List.from(json['Category']).map((e) => Category.fromJson(e)).toList();
      reviews = Reviews.fromJson(json['reviews']);
      inStock = json['in_stock'];
      isSaved = json['is_saved'];
      isWishlisted = json['is_wishlisted'];
      isItemInCart = json['is_item_in_cart'];
      showQuantityChanger = json['show_quantity_changer'];
      specialPrice = json['special_price'];
      formatedSpecialPrice = json['formated_special_price'];
      regularPrice = json['regular_price'];
      formatedRegularPrice = json['formated_regular_price'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    // _data['Category'] = Category.map((e) => e.toJson()).toList();
    _data['reviews'] = reviews.toJson();
    _data['in_stock'] = inStock;
    _data['is_saved'] = isSaved;
    _data['is_wishlisted'] = isWishlisted;
    _data['is_item_in_cart'] = isItemInCart;
    _data['show_quantity_changer'] = showQuantityChanger;
    _data['special_price'] = specialPrice;
    _data['formated_special_price'] = formatedSpecialPrice;
    _data['regular_price'] = regularPrice;
    _data['formated_regular_price'] = formatedRegularPrice;
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

class Category {
  Category({
    required this.name,
  });
  late final String name;

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
  late final String total;
  late final String totalRating;
  late final String averageRating;
  late final String percentage;

  Reviews.fromJson(Map<String, dynamic> json) {
    total = json['total'].toString();
    totalRating = json['total_rating'];
    averageRating = json['average_rating'];
    percentage = json['percentage'].toString();
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

class Additional {
  Additional({
    required this.quantity,
    required this.productId,
    required this.token,
    required this.locale,
  });
  late final int quantity;
  late final String productId;
  late final String token;
  late final String locale;

  Additional.fromJson(Map<String, dynamic> json) {
    quantity = int.parse(json['quantity'].toString());
    productId = json['product_id'].toString();
    token = json['_token'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    _data['product_id'] = productId;
    _data['_token'] = token;
    _data['locale'] = locale;
    return _data;
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });
  late final String first;
  late final String last;
  late final Null prev;
  late final Null next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = null;
    next = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['prev'] = prev;
    _data['next'] = next;
    return _data;
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.link,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final List<Link> link;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    link = List.from(json['link']).map((e) => Link.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['link'] = link.map((e) => e.toJson()).toList();
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });
  late final String? url;
  late final String label;
  late final bool active;

  Link.fromJson(Map<String, dynamic> json) {
    url = null;
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
