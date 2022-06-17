class ProductDetail {
  late Data data;

  ProductDetail({required this.data});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sku;
  String? type;
  String? name;
  String? urlKey;
  String? price;
  String? formatedPrice;
  String? shortDescription;
  String? description;
  List<Images>? images;
  BaseImage? baseImage;
  String? createdAt;
  String? updatedAt;
  Reviews? reviews;
  bool? inStock;
  bool? isSaved;
  bool? isWishlisted;
  bool? isItemInCart;
  bool? showQuantityChanger;
  List<Variants>? variants;
  List<SuperAttributes>? superAttributes;
  String? specialPrice;
  String? formatedSpecialPrice;
  Data(
      {required this.id,
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
      required this.reviews,
      required this.inStock,
      required this.isSaved,
      required this.isWishlisted,
      required this.isItemInCart,
      required this.showQuantityChanger,
      required this.specialPrice,
      required this.formatedSpecialPrice,
      required this.variants,
      required this.superAttributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    type = json['type'];
    name = json['name'];
    urlKey = json['url_key'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    shortDescription = json['short_description'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    baseImage = json['base_image'] != null
        ? new BaseImage.fromJson(json['base_image'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviews =
        json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
    inStock = json['in_stock'];
    isSaved = json['is_saved'];
    isWishlisted = json['is_wishlisted'];
    isItemInCart = json['is_item_in_cart'];
    specialPrice = json['special_price'];
    formatedSpecialPrice = json['formated_special_price'];
    showQuantityChanger = json['show_quantity_changer'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['super_attributes'] != null) {
      superAttributes = <SuperAttributes>[];
      json['super_attributes'].forEach((v) {
        superAttributes!.add(new SuperAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url_key'] = this.urlKey;
    data['price'] = this.price;
    data['formated_price'] = this.formatedPrice;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.baseImage != null) {
      data['base_image'] = this.baseImage!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    data['in_stock'] = this.inStock;
    data['is_saved'] = this.isSaved;
    data['is_wishlisted'] = this.isWishlisted;
    data['is_item_in_cart'] = this.isItemInCart;
    data['show_quantity_changer'] = this.showQuantityChanger;
    data['specialPrice'] = specialPrice;
    data['formatedSpecialPrice'] = formatedSpecialPrice;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.superAttributes != null) {
      data['super_attributes'] =
          this.superAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? path;
  String? url;
  String? originalImageUrl;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;

  Images(
      {this.id,
      this.path,
      this.url,
      this.originalImageUrl,
      this.smallImageUrl,
      this.mediumImageUrl,
      this.largeImageUrl});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['url'] = this.url;
    data['original_image_url'] = this.originalImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class BaseImage {
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  String? originalImageUrl;

  BaseImage(
      {required this.smallImageUrl,
      required this.mediumImageUrl,
      required this.largeImageUrl,
      required this.originalImageUrl});

  BaseImage.fromJson(Map<String, dynamic> json) {
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    originalImageUrl = json['original_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small_image_url'] = this.smallImageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['original_image_url'] = this.originalImageUrl;
    return data;
  }
}

class Reviews {
  String? total;
  String? totalRating;
  String? averageRating;
  String? percentage;

  Reviews({this.total, this.totalRating, this.averageRating, this.percentage});

  Reviews.fromJson(Map<String, dynamic> json) {
    total = json['total'].toString();
    totalRating = json['total_rating'].toString();
    averageRating = json['average_rating'].toString();
    percentage = json['percentage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_rating'] = this.totalRating;
    data['average_rating'] = this.averageRating;
    data['percentage'] = this.percentage;
    return data;
  }
}

class Variants {
  int? id;
  String? sku;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? parentId;
  int? attributeFamilyId;
  Null? additional;
  String? price;
  String? shortDescription;
  String? description;
  String? name;
  String? urlKey;
  int? taxCategoryId;
  int? neww;
  int? featured;
  int? visibleIndividually;
  int? status;
  int? color;
  int? size;
  Null? brand;
  int? guestCheckout;
  String? productNumber;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? cost;
  String? specialPrice;
  String? specialPriceFrom;
  String? specialPriceTo;
  String? length;
  String? width;
  String? height;
  int? shoescode;
  String? weight;
  String? variant_image;
  List<Inventories>? inventories;
  List<Null>? customerGroupPrices;
  AttributeFamily? attributeFamily;

  Variants(
      {this.id,
      this.sku,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.parentId,
      this.attributeFamilyId,
      this.additional,
      this.price,
      this.shortDescription,
      this.description,
      this.name,
      this.urlKey,
      this.taxCategoryId,
      this.neww,
      this.featured,
      this.variant_image,
      this.visibleIndividually,
      this.status,
      this.color,
      this.shoescode,
      this.size,
      this.brand,
      this.guestCheckout,
      this.productNumber,
      this.metaTitle,
      this.metaKeywords,
      this.metaDescription,
      this.cost,
      this.specialPrice,
      this.specialPriceFrom,
      this.specialPriceTo,
      this.length,
      this.width,
      this.height,
      this.weight,
      this.inventories,
      this.customerGroupPrices,
      this.attributeFamily});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shoescode = json['shoescode'];
    parentId = json['parent_id'];
    attributeFamilyId = json['attribute_family_id'];
    additional = json['additional'];
    variant_image = json['variant_image'];
    price = json['price'];
    shortDescription = json['short_description'];
    description = json['description'];
    name = json['name'];
    urlKey = json['url_key'];
    taxCategoryId = json['tax_category_id'];
    neww = json['new'];
    featured = json['featured'];
    visibleIndividually = json['visible_individually'];
    status = json['status'];
    color = json['color'];
    size = json['size'];
    brand = json['brand'];
    guestCheckout = json['guest_checkout'];
    productNumber = json['product_number'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    cost = json['cost'];
    specialPrice = json['special_price'];
    specialPriceFrom = json['special_price_from'];
    specialPriceTo = json['special_price_to'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    if (json['inventories'] != null) {
      inventories = <Inventories>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Inventories.fromJson(v));
      });
    }
    if (json['customer_group_prices'] != null) {
      customerGroupPrices = <Null>[];
      // json['customer_group_prices'].forEach((v) {
      //   customerGroupPrices!.add(new Null.fromJson(v));
      // });
    }
    attributeFamily = json['attribute_family'] != null
        ? new AttributeFamily.fromJson(json['attribute_family'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parent_id'] = this.parentId;
    data['variant_image'] = this.variant_image;
    data['attribute_family_id'] = this.attributeFamilyId;
    data['additional'] = this.additional;
    data['price'] = this.price;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['name'] = this.name;
    data['url_key'] = this.urlKey;
    data['tax_category_id'] = this.taxCategoryId;
    data['new'] = this.neww;
    data['featured'] = this.featured;
    data['visible_individually'] = this.visibleIndividually;
    data['status'] = this.status;
    data['color'] = this.color;
    data['size'] = this.size;
    data['brand'] = this.brand;
    data['guest_checkout'] = this.guestCheckout;
    data['product_number'] = this.productNumber;
    data['meta_title'] = this.metaTitle;
    data['shoescode'] = this.shoescode;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['cost'] = this.cost;
    data['special_price'] = this.specialPrice;
    data['special_price_from'] = this.specialPriceFrom;
    data['special_price_to'] = this.specialPriceTo;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['weight'] = this.weight;
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    if (this.customerGroupPrices != null) {
      // data['customer_group_prices'] =
      //     this.customerGroupPrices!.map((v) => v.toJson()).toList();
    }
    if (this.attributeFamily != null) {
      data['attribute_family'] = this.attributeFamily!.toJson();
    }
    return data;
  }
}

class Inventories {
  int? id;
  int? qty;
  int? productId;
  int? inventorySourceId;
  int? vendorId;

  Inventories(
      {this.id,
      this.qty,
      this.productId,
      this.inventorySourceId,
      this.vendorId});

  Inventories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    productId = json['product_id'];
    inventorySourceId = json['inventory_source_id'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['product_id'] = this.productId;
    data['inventory_source_id'] = this.inventorySourceId;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class AttributeFamily {
  int? id;
  String? code;
  String? name;
  int? status;
  int? isUserDefined;

  AttributeFamily(
      {this.id, this.code, this.name, this.status, this.isUserDefined});

  AttributeFamily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
    isUserDefined = json['is_user_defined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['status'] = this.status;
    data['is_user_defined'] = this.isUserDefined;
    return data;
  }
}

class SuperAttributes {
  int? id;
  String? code;
  String? type;
  String? name;
  String? swatchType;
  List<Options>? options;
  String? createdAt;
  String? updatedAt;

  SuperAttributes(
      {this.id,
      this.code,
      this.type,
      this.name,
      this.swatchType,
      this.options,
      this.createdAt,
      this.updatedAt});

  SuperAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    name = json['name'];
    swatchType = json['swatch_type'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['name'] = this.name;
    data['swatch_type'] = this.swatchType;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Options {
  int? id;
  String? adminName;
  String? label;
  String? swatchValue;

  Options({this.id, this.adminName, this.label, this.swatchValue});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminName = json['admin_name'];
    label = json['label'];
    swatchValue = json['swatch_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_name'] = this.adminName;
    data['label'] = this.label;
    data['swatch_value'] = this.swatchValue;
    return data;
  }
}
