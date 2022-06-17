import 'package:MakkiHerb/models/CategoryProduct.dart';

class ReviewsByID {
  ReviewsByID({
    required this.data,
    // required this.links,
    // required this.meta,
  });
  late final List<Data> data;
  late final Links links;
  late final Meta meta;

  ReviewsByID.fromJson(Map<String, dynamic> json) {
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
    required this.title,
    required this.rating,
    required this.comment,
    required this.name,
    required this.status,
    required this.product,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String rating;
  late final String comment;
  late final String name;
  late final String status;
  late final Product product;
  late final Customer customer;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['rating'];
    comment = json['comment'];
    name = json['name'];
    status = json['status'];
    product = Product.fromJson(json['product']);
    customer = Customer.fromJson(json['customer']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['rating'] = rating;
    _data['comment'] = comment;
    _data['name'] = name;
    _data['status'] = status;
    _data['product'] = product.toJson();
    _data['customer'] = customer.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
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
    required this.Category,
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
  late final int productQty;
  late final List<CategoryProduct> Category;
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
    Category = List.from(json['Category'])
        .map((e) => CategoryProduct.fromJson(e))
        .toList();
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
    _data['product_qty'] = productQty;
    _data['Category'] = Category.map((e) => e.toJson()).toList();
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

class Customer {
  Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.gender,
    this.dateOfBirth,
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
  late final String? dateOfBirth;
  late final String phone;
  late final String? profile;
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
    profile = json['profile'];
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
