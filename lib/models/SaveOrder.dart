class SaveOrder {
  SaveOrder({
    required this.success,
    required this.order,
  });
  late final bool success;
  late final Order order;

  SaveOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['order'] = order.toJson();
    return _data;
  }
}

class Order {
  Order({
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
    this.isGift,
    required this.totalItemCount,
    required this.totalQtyOrdered,
    required this.grandTotal,
    required this.baseGrandTotal,
    this.grandTotalInvoiced,
    this.grandTotalRefunded,
    this.baseGrandTotalRefunded,
    required this.subTotal,
    required this.baseSubTotal,
    this.subTotalInvoiced,
    this.baseSubTotalInvoiced,
    this.subTotalRefunded,
    this.discountPercent,
    required this.discountAmount,
    required this.baseDiscountAmount,
    this.discountInvoiced,
    this.baseDiscountInvoiced,
    this.discountRefunded,
    this.baseDiscountRefunded,
    required this.taxAmount,
    required this.baseTaxAmount,
    this.taxAmountInvoiced,
    this.baseTaxAmountInvoiced,
    this.taxAmountRefunded,
    this.baseTaxAmountRefunded,
    required this.shippingAmount,
    required this.baseShippingAmount,
    this.shippingInvoiced,
    this.baseShippingInvoiced,
    this.shippingRefunded,
    this.baseShippingRefunded,
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
  late final Null isGift;
  late final int totalItemCount;
  late final String totalQtyOrdered;
  late final String grandTotal;
  late final String baseGrandTotal;
  late final Null grandTotalInvoiced;
  late final Null grandTotalRefunded;
  late final Null baseGrandTotalRefunded;
  late final String subTotal;
  late final String baseSubTotal;
  late final Null subTotalInvoiced;
  late final Null baseSubTotalInvoiced;
  late final Null subTotalRefunded;
  late final Null discountPercent;
  late final String discountAmount;
  late final String baseDiscountAmount;
  late final Null discountInvoiced;
  late final Null baseDiscountInvoiced;
  late final Null discountRefunded;
  late final Null baseDiscountRefunded;
  late final String taxAmount;
  late final String baseTaxAmount;
  late final Null taxAmountInvoiced;
  late final Null baseTaxAmountInvoiced;
  late final Null taxAmountRefunded;
  late final Null baseTaxAmountRefunded;
  late final int shippingAmount;
  late final int baseShippingAmount;
  late final Null shippingInvoiced;
  late final Null baseShippingInvoiced;
  late final Null shippingRefunded;
  late final Null baseShippingRefunded;
  late final Customer customer;
  late final ShippingAddress shippingAddress;
  late final BillingAddress billingAddress;
  late final List<Items> items;
  late final List<dynamic> shipments;
  late final String updatedAt;
  late final String createdAt;

  Order.fromJson(Map<String, dynamic> json) {
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
    isGift = null;
    totalItemCount = json['total_item_count'];
    totalQtyOrdered = json['total_qty_ordered'];
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    grandTotalInvoiced = null;
    grandTotalRefunded = null;
    baseGrandTotalRefunded = null;
    subTotal = json['sub_total'];
    baseSubTotal = json['base_sub_total'];
    subTotalInvoiced = null;
    baseSubTotalInvoiced = null;
    subTotalRefunded = null;
    discountPercent = null;
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountInvoiced = null;
    baseDiscountInvoiced = null;
    discountRefunded = null;
    baseDiscountRefunded = null;
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxAmountInvoiced = null;
    baseTaxAmountInvoiced = null;
    taxAmountRefunded = null;
    baseTaxAmountRefunded = null;
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingInvoiced = null;
    baseShippingInvoiced = null;
    shippingRefunded = null;
    baseShippingRefunded = null;
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
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
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
  late final String gender;
  late final String dateOfBirth;
  late final String phone;
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
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    phone = json['phone'];
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
    // baseGrantTotal = json['base_grant_total'];
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
    required this.Category,
    required this.reviews,
    required this.inStock,
    required this.isSaved,
    required this.isWishlisted,
    required this.isItemInCart,
    required this.showQuantityChanger,
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
  late final List<Categorys> Category;
  late final Reviews reviews;
  late final bool inStock;
  late final bool isSaved;
  late final bool isWishlisted;
  late final bool isItemInCart;
  late final bool showQuantityChanger;

  Product.fromJson(Map<String, dynamic> json) {
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
    Category =
        List.from(json['Category']).map((e) => Categorys.fromJson(e)).toList();
    reviews = Reviews.fromJson(json['reviews']);
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
    _data['Category'] = Category.map((e) => e.toJson()).toList();
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

class Categorys {
  Categorys({
    required this.name,
  });
  late final String name;

  Categorys.fromJson(Map<String, dynamic> json) {
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
    totalRating = json['total_rating'].toString();
    averageRating = json['average_rating'].toString();
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
    required this.productId,
    required this.quantity,
    required this.token,
    required this.locale,
  });
  late final String productId;
  late final int quantity;
  late final String token;
  late final String locale;

  Additional.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    token = json['token'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    _data['token'] = token;
    _data['locale'] = locale;
    return _data;
  }
}
