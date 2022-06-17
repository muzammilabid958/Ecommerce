
class Categories {
  Categories({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<Data> data;
  late final Links links;
  late final Meta meta;

  Categories.fromJson(Map<String, dynamic> json) {
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
