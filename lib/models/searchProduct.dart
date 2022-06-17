class SearchProduct {
  SearchProduct({
    required this.data,
  });
  late final List<Data> data;

  SearchProduct.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.sku,
    required this.productNumber,
    required this.name,
    required this.description,
    required this.urlKey,
    required this.new2,
    required this.featured,
    required this.status,
    this.thumbnail,
    required this.price,
    required this.cost,
    required this.specialPrice,
    required this.specialPriceFrom,
    required this.specialPriceTo,
    required this.weight,
    required this.color,
    required this.colorLabel,
    required this.size,
    required this.sizeLabel,
    required this.createdAt,
    required this.locale,
    required this.channel,
    required this.productId,
    required this.updatedAt,
    this.parentId,
    required this.visibleIndividually,
    required this.minPrice,
    required this.maxPrice,
    required this.shortDescription,
    required this.metaTitle,
    required this.metaKeywords,
    required this.metaDescription,
    required this.width,
    required this.height,
    this.depth,
    required this.images_url,
  });
  late final int id;
  late final String sku;
  late final String productNumber;
  late final String name;
  late final String description;
  late final String urlKey;
  late final int new2;
  late final int featured;
  late final int status;
  late final Null thumbnail;
  late final String price;
  late final String cost;
  late final String specialPrice;
  late final String specialPriceFrom;
  late final String specialPriceTo;
  late final String weight;
  late final int color;
  late final String colorLabel;
  late final int size;
  late final String sizeLabel;
  late final String createdAt;
  late final String locale;
  late final String channel;
  late final int productId;
  late final String updatedAt;
  late final Null parentId;
  late final int visibleIndividually;
  late final String minPrice;
  late final String maxPrice;
  late final String shortDescription;
  late final String metaTitle;
  late final String metaKeywords;
  late final String metaDescription;
  late final String width;
  late final String height;
  late final String images_url;
  late final Null depth;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    productNumber = json['product_number'];
    name = json['name'];
    description = json['description'];
    urlKey = json['url_key'];
    new2 = json['new'];
    featured = json['featured'];
    status = json['status'];
    thumbnail = null;
    price = json['price'];
    cost = json['cost'];
    specialPrice = json['special_price'];
    specialPriceFrom = json['special_price_from'];
    specialPriceTo = json['special_price_to'];
    weight = json['weight'];
    color = json['color'];
    colorLabel = json['color_label'];
    size = json['size'];
    sizeLabel = json['size_label'];
    createdAt = json['created_at'];
    locale = json['locale'];
    channel = json['channel'];
    productId = json['product_id'];
    updatedAt = json['updated_at'];
    parentId = null;
    visibleIndividually = json['visible_individually'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    shortDescription = json['short_description'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    width = json['width'];
    height = json['height'];
    images_url = json['images_url'];
    depth = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sku'] = sku;
    _data['product_number'] = productNumber;
    _data['name'] = name;
    _data['description'] = description;
    _data['url_key'] = urlKey;
    _data['new'] = new2;
    _data['featured'] = featured;
    _data['status'] = status;
    _data['thumbnail'] = thumbnail;
    _data['price'] = price;
    _data['cost'] = cost;
    _data['special_price'] = specialPrice;
    _data['special_price_from'] = specialPriceFrom;
    _data['special_price_to'] = specialPriceTo;
    _data['weight'] = weight;
    _data['color'] = color;
    _data['color_label'] = colorLabel;
    _data['size'] = size;
    _data['size_label'] = sizeLabel;
    _data['created_at'] = createdAt;
    _data['locale'] = locale;
    _data['channel'] = channel;
    _data['product_id'] = productId;
    _data['updated_at'] = updatedAt;
    _data['parent_id'] = parentId;
    _data['visible_individually'] = visibleIndividually;
    _data['min_price'] = minPrice;
    _data['max_price'] = maxPrice;
    _data['short_description'] = shortDescription;
    _data['meta_title'] = metaTitle;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['width'] = width;
    _data['height'] = height;
    _data['depth'] = depth;
    _data['images_url'] = images_url;
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    this.type,
    required this.path,
    required this.url,
    required this.productId,
  });
  late final int id;
  late final Null type;
  late final String path;
  late final String url;
  late final int productId;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = null;
    path = json['path'];
    url = json['url'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['path'] = path;
    _data['url'] = url;
    _data['product_id'] = productId;
    return _data;
  }
}
