class FetchAddress {
  FetchAddress({
    required this.data,
  });
  late final List<Data> data;

  FetchAddress.fromJson(Map<String, dynamic> json) {
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
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.vatId,
    required this.address1,
    required this.country,
    required this.countryName,
    required this.state,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final Null companyName;
  late final Null vatId;
  late final List<String> address1;
  late final String country;
  late final String countryName;
  late final String state;
  late final String city;
  late final String postcode;
  late final String phone;
  late final bool isDefault;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyName = null;
    vatId = null;
    address1 = List.castFrom<dynamic, String>(json['address1']);
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['company_name'] = companyName;
    _data['vat_id'] = vatId;
    _data['address1'] = address1;
    _data['country'] = country;
    _data['country_name'] = countryName;
    _data['state'] = state;
    _data['city'] = city;
    _data['postcode'] = postcode;
    _data['phone'] = phone;
    _data['is_default'] = isDefault;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
