class SaveAddresss {
  SaveAddresss({
    required this.billing,
    required this.shipping,
  });
  late final Billing billing;
  late final Shipping shipping;

  SaveAddresss.fromJson(Map<String, dynamic> json) {
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
    required this.addressId,
  });
  late final Address1 address1;
  late final String useForShipping;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final int addressId;

  Billing.fromJson(Map<String, dynamic> json) {
    address1 = Address1.fromJson(json['address1']);
    useForShipping = json['use_for_shipping'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1.toJson();
    _data['use_for_shipping'] = useForShipping;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['address_id'] = addressId;
    return _data;
  }
}

class Address1 {
  Address1({
    required this.addressBilling,
  });
  late final String addressBilling;

  Address1.fromJson(Map<String, dynamic> json) {
    addressBilling = json['address_billing'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address_billing'] = addressBilling;
    return _data;
  }
}

class Shipping {
  Shipping({
    required this.address1,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.addressId,
  });
  late final Address1 address1;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final int addressId;

  Shipping.fromJson(Map<String, dynamic> json) {
    address1 = Address1.fromJson(json['address1']);
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1.toJson();
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['address_id'] = addressId;
    return _data;
  }
}
