class FilteredProduct {
  FilteredProduct({
    required this.data,
  });
  late final List<Data> data;

  FilteredProduct.fromJson(Map<String, dynamic> json) {
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
    required this.neww,
    required this.featured,
    required this.status,
    this.thumbnail,
    this.price,
    this.cost,
    this.specialPrice,
    this.specialPriceFrom,
    this.specialPriceTo,
    this.weight,
    this.color,
    this.colorLabel,
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
    this.width,
    this.height,
    this.depth,
    this.shoescode,
    this.shoescodeLabel,
    required this.flashSale,
    required this.image,
  });
  late final int id;
  late final String sku;
  late final String productNumber;
  late final String name;
  late final String description;
  late final String urlKey;
  late final int neww;
  late final int featured;
  late final int status;
  late final Null thumbnail;
  late final String? price;
  late final String? cost;
  late final Null specialPrice;
  late final Null specialPriceFrom;
  late final Null specialPriceTo;
  late final String? weight;
  late final int? color;
  late final String? colorLabel;
  late final int size;
  late final String sizeLabel;
  late final String createdAt;
  late final String locale;
  late final String channel;
  late final int productId;
  late final String updatedAt;
  late final int? parentId;
  late final int visibleIndividually;
  late final String minPrice;
  late final String maxPrice;
  late final String shortDescription;
  late final String metaTitle;
  late final String metaKeywords;
  late final String metaDescription;
  late final String? width;
  late final String? height;
  late final Null depth;
  late final int? shoescode;
  late final String? shoescodeLabel;
  late final int flashSale;
  late final String image;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    productNumber = json['product_number'];
    name = json['name'];
    description = json['description'];
    urlKey = json['url_key'];
    neww = json['new'];
    featured = json['featured'];
    status = json['status'];
    thumbnail = null;
    price = json['price'];
    cost = null;
    specialPrice = null;
    specialPriceFrom = null;
    specialPriceTo = null;
    weight = null;
    color = null;
    colorLabel = null;
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
    width = null;
    height = null;
    depth = null;
    shoescode = null;
    shoescodeLabel = null;
    flashSale = json['flash_sale'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sku'] = sku;
    _data['product_number'] = productNumber;
    _data['name'] = name;
    _data['description'] = description;
    _data['url_key'] = urlKey;
    _data['new'] = neww;
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
    _data['shoescode'] = shoescode;
    _data['shoescode_label'] = shoescodeLabel;
    _data['flash_sale'] = flashSale;
    _data['image'] = image;
    return _data;
  }
}
