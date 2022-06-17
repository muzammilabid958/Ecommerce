class CustomerShippment {
  CustomerShippment({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<Data> data;
  late final Links links;
  late final Meta meta;

  CustomerShippment.fromJson(Map<String, dynamic> json) {
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
    this.status,
    required this.totalQty,
    this.totalWeight,
    this.carrierCode,
    required this.carrierTitle,
    required this.trackNumber,
    required this.emailSent,
    required this.customer,
    required this.inventorySource,
    required this.items,
  });
  late final int id;
  late final Null status;
  late final int totalQty;
  late final Null totalWeight;
  late final Null carrierCode;
  late final String carrierTitle;
  late final String trackNumber;
  late final int emailSent;
  late final Customer customer;
  late final InventorySource inventorySource;
  late final List<Items> items;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = null;
    totalQty = json['total_qty'];
    totalWeight = null;
    carrierCode = null;
    carrierTitle = json['carrier_title'];
    trackNumber = json['track_number'];
    emailSent = json['email_sent'];
    customer = Customer.fromJson(json['customer']);
    inventorySource = InventorySource.fromJson(json['inventory_source']);
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['total_qty'] = totalQty;
    _data['total_weight'] = totalWeight;
    _data['carrier_code'] = carrierCode;
    _data['carrier_title'] = carrierTitle;
    _data['track_number'] = trackNumber;
    _data['email_sent'] = emailSent;
    _data['customer'] = customer.toJson();
    _data['inventory_source'] = inventorySource.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
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
    required this.group,
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
  late final Group group;
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
    group = Group.fromJson(json['group']);
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
    _data['group'] = group.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Group {
  Group({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String name;
  late final Null createdAt;
  late final Null updatedAt;

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class InventorySource {
  InventorySource({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    required this.contactName,
    required this.contactEmail,
    required this.contactNumber,
    this.contactFax,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    required this.postcode,
    required this.priority,
    this.latitude,
    this.longitude,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String code;
  late final String name;
  late final Null description;
  late final String contactName;
  late final String contactEmail;
  late final String contactNumber;
  late final Null contactFax;
  late final String country;
  late final String state;
  late final String city;
  late final String street;
  late final String postcode;
  late final int priority;
  late final Null latitude;
  late final Null longitude;
  late final int status;
  late final Null createdAt;
  late final Null updatedAt;

  InventorySource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = null;
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactNumber = json['contact_number'];
    contactFax = null;
    country = json['country'];
    state = json['state'];
    city = json['city'];
    street = json['street'];
    postcode = json['postcode'];
    priority = json['priority'];
    latitude = null;
    longitude = null;
    status = json['status'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['name'] = name;
    _data['description'] = description;
    _data['contact_name'] = contactName;
    _data['contact_email'] = contactEmail;
    _data['contact_number'] = contactNumber;
    _data['contact_fax'] = contactFax;
    _data['country'] = country;
    _data['state'] = state;
    _data['city'] = city;
    _data['street'] = street;
    _data['postcode'] = postcode;
    _data['priority'] = priority;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.name,
    this.description,
    required this.sku,
    required this.qty,
    required this.weight,
    required this.price,
    required this.formatedPrice,
    required this.basePrice,
    required this.formatedBasePrice,
    required this.total,
    required this.formatedTotal,
    required this.baseTotal,
    required this.formatedBaseTotal,
    required this.additional,
  });
  late final int id;
  late final String name;
  late final Null description;
  late final String sku;
  late final int qty;
  late final int weight;
  late final String price;
  late final String formatedPrice;
  late final String basePrice;
  late final String formatedBasePrice;
  late final String total;
  late final String formatedTotal;
  late final String baseTotal;
  late final String formatedBaseTotal;
  late final Additional additional;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = null;
    sku = json['sku'];
    qty = json['qty'];
    weight = json['weight'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    basePrice = json['base_price'];
    formatedBasePrice = json['formated_base_price'];
    total = json['total'];
    formatedTotal = json['formated_total'];
    baseTotal = json['base_total'];
    formatedBaseTotal = json['formated_base_total'];
    additional = Additional.fromJson(json['additional']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['sku'] = sku;
    _data['qty'] = qty;
    _data['weight'] = weight;
    _data['price'] = price;
    _data['formated_price'] = formatedPrice;
    _data['base_price'] = basePrice;
    _data['formated_base_price'] = formatedBasePrice;
    _data['total'] = total;
    _data['formated_total'] = formatedTotal;
    _data['base_total'] = baseTotal;
    _data['formated_base_total'] = formatedBaseTotal;
    _data['additional'] = additional.toJson();
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
