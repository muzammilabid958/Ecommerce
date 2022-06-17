class WishListProduct {
  late List<Data>? data;
  // late Links? links;
  // late Meta? meta;

  WishListProduct({
    this.data,
    // this.links,
    // this.meta,
  });

  WishListProduct.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List)
        .map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
        .toList();
    // links = Links.fromJson(json['links'] as Map<String, dynamic>);
    // meta = (json['meta'] as Map<String, dynamic>) != null
    //     ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data!.map((e) => e.toJson()).toList();
    // json['links'] = links!.toJson();
    // json['meta'] = meta?.toJson();
    return json;
  }
}

class Data {
  int? id;
  Product? product;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    product = (json['product'] as Map<String, dynamic>?) != null
        ? Product.fromJson(json['product'] as Map<String, dynamic>)
        : null;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['product'] = product?.toJson();
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    return json;
  }
}

class Product {
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
  // Reviews? reviews;
  bool? inStock;
  bool? isSaved;
  bool? isWishlisted;
  bool? isItemInCart;
  bool? showQuantityChanger;

  Product({
    this.id,
    this.sku,
    this.type,
    this.name,
    this.urlKey,
    this.price,
    this.formatedPrice,
    this.shortDescription,
    this.description,
    this.images,
    this.baseImage,
    this.createdAt,
    this.updatedAt,
    // this.reviews,
    this.inStock,
    this.isSaved,
    this.isWishlisted,
    this.isItemInCart,
    this.showQuantityChanger,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    sku = json['sku'] as String?;
    type = json['type'] as String?;
    name = json['name'] as String?;
    urlKey = json['url_key'] as String?;
    price = json['price'] as String?;
    formatedPrice = json['formated_price'] as String?;
    shortDescription = json['short_description'] as String?;
    description = json['description'] as String?;
    images = (json['images'] as List?)
        ?.map((dynamic e) => Images.fromJson(e as Map<String, dynamic>))
        .toList();
    baseImage = (json['base_image'] as Map<String, dynamic>?) != null
        ? BaseImage.fromJson(json['base_image'] as Map<String, dynamic>)
        : null;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    // reviews = (json['reviews'] as Map<String, dynamic>?) != null
    //     ? Reviews.fromJson(json['reviews'] as Map<String, dynamic>)
    //     : null;
    inStock = json['in_stock'] as bool?;
    isSaved = json['is_saved'] as bool?;
    isWishlisted = json['is_wishlisted'] as bool?;
    isItemInCart = json['is_item_in_cart'] as bool?;
    showQuantityChanger = json['show_quantity_changer'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['sku'] = sku;
    json['type'] = type;
    json['name'] = name;
    json['url_key'] = urlKey;
    json['price'] = price;
    json['formated_price'] = formatedPrice;
    json['short_description'] = shortDescription;
    json['description'] = description;
    json['images'] = images?.map((e) => e.toJson()).toList();
    json['base_image'] = baseImage?.toJson();
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    // json['reviews'] = reviews?.toJson();
    json['in_stock'] = inStock;
    json['is_saved'] = isSaved;
    json['is_wishlisted'] = isWishlisted;
    json['is_item_in_cart'] = isItemInCart;
    json['show_quantity_changer'] = showQuantityChanger;
    return json;
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

  Images({
    this.id,
    this.path,
    this.url,
    this.originalImageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    path = json['path'] as String?;
    url = json['url'] as String?;
    originalImageUrl = json['original_image_url'] as String?;
    smallImageUrl = json['small_image_url'] as String?;
    mediumImageUrl = json['medium_image_url'] as String?;
    largeImageUrl = json['large_image_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['path'] = path;
    json['url'] = url;
    json['original_image_url'] = originalImageUrl;
    json['small_image_url'] = smallImageUrl;
    json['medium_image_url'] = mediumImageUrl;
    json['large_image_url'] = largeImageUrl;
    return json;
  }
}

class BaseImage {
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  String? originalImageUrl;

  BaseImage({
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.originalImageUrl,
  });

  BaseImage.fromJson(Map<String, dynamic> json) {
    smallImageUrl = json['small_image_url'] as String?;
    mediumImageUrl = json['medium_image_url'] as String?;
    largeImageUrl = json['large_image_url'] as String?;
    originalImageUrl = json['original_image_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['small_image_url'] = smallImageUrl;
    json['medium_image_url'] = mediumImageUrl;
    json['large_image_url'] = largeImageUrl;
    json['original_image_url'] = originalImageUrl;
    return json;
  }
}
