class GuestShippingAdresses {
  GuestShippingAdresses({
    required this.billing,
    required this.shipping,
  });
  late final Billing billing;
  late final Shipping shipping;

  GuestShippingAdresses.fromJson(Map<String, dynamic> json) {
    billing = Billing.fromJson(json['billing']);
    shipping = Shipping.fromJson(json['shipping']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billing'] = billing.toJson();
    _data['shipping'] = shipping.toJson();
    return _data;
  }
}

class Billing {
  Billing({
    required this.address1,
    required this.useForShipping,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
  });
  late final Address1 address1;
  late final String useForShipping;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String city;
  late final String state;
  late final String postcode;
  late final String country;
  late final String phone;

  Billing.fromJson(Map<String, dynamic> json) {
    address1 = Address1.fromJson(json['address1']);
    useForShipping = json['use_for_shipping'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1.toJson();
    _data['use_for_shipping'] = useForShipping;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['city'] = city;
    _data['state'] = state;
    _data['postcode'] = postcode;
    _data['country'] = country;
    _data['phone'] = phone;
    return _data;
  }
}

class Address1 {
  Address1({
    required this.address,
  });
  late final String address;

  Address1.fromJson(Map<String, dynamic> json) {
    address = json['0'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['0'] = address;
    return _data;
  }
}

class Shipping {
  Shipping({
    required this.address1,
  });
  late final Address1 address1;

  Shipping.fromJson(Map<String, dynamic> json) {
    address1 = Address1.fromJson(json['address1']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1.toJson();
    return _data;
  }
}
