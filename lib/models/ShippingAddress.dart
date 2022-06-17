class ShippingAdresses {
  ShippingAdresses({
    required this.address1,
    required this.city,
    required this.country,
    required this.countryName,
    required this.phone,
    required this.postcode,
    required this.state,
  });
  late final List<String> address1;
  late final String city;
  late final String country;
  late final String countryName;
  late final String phone;
  late final String postcode;
  late final String state;

  ShippingAdresses.fromJson(Map<String, dynamic> json) {
    address1 = List.castFrom<dynamic, String>(json['address1']);
    city = json['city'];
    country = json['country'];
    countryName = json['country_name'];
    phone = json['phone'];
    postcode = json['postcode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1;
    _data['city'] = city;
    _data['country'] = country;
    _data['country_name'] = countryName;
    _data['phone'] = phone;
    _data['postcode'] = postcode;
    _data['state'] = state;
    return _data;
  }
}

class EditShippingAdresses {
  EditShippingAdresses(
      {required this.address1,
      required this.city,
      required this.country,
      required this.countryName,
      required this.phone,
      required this.postcode,
      required this.state,
      required this.id});
  late final List<String> address1;
  late final String city;
  late final String id;
  late final String country;
  late final String countryName;
  late final String phone;
  late final String postcode;
  late final String state;
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1;
    _data['city'] = city;
    _data['country'] = country;
    _data['country_name'] = countryName;
    _data['phone'] = phone;
    _data['postcode'] = postcode;
    _data['state'] = state;
    return _data;
  }
}
