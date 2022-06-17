class DescendantCategory {
  DescendantCategory({
    required this.data,
  });
  late final List<Data> data;

  DescendantCategory.fromJson(Map<String, dynamic> json) {
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
    this.code,
    required this.name,
    required this.slug,
    required this.displayMode,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
    required this.status,
    required this.imageUrl,
    required this.categoryIconPath,
    this.additional,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final Null code;
  late final String name;
  late final String slug;
  late final String displayMode;
  late final String description;
  late final String metaTitle;
  late final String metaDescription;
  late final String metaKeywords;
  late final int status;
  late final String imageUrl;
  late final String categoryIconPath;
  late final Null additional;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = null;
    name = json['name'];
    slug = json['slug'];
    displayMode = json['display_mode'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    status = json['status'];
    imageUrl = json['image_url'];
    categoryIconPath = json['category_icon_path'];
    additional = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['display_mode'] = displayMode;
    _data['description'] = description;
    _data['meta_title'] = metaTitle;
    _data['meta_description'] = metaDescription;
    _data['meta_keywords'] = metaKeywords;
    _data['status'] = status;
    _data['image_url'] = imageUrl;
    _data['category_icon_path'] = categoryIconPath;
    _data['additional'] = additional;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
