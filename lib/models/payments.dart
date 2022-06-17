class Payments {
  Payments({
    required this.payment,
  });
  late final Paymentsss payment;

  Payments.fromJson(Map<String, dynamic> json) {
    payment = Paymentsss.fromJson(json['payment']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment'] = payment.toJson();
    return _data;
  }
}

class Paymentsss {
  Paymentsss({
    required this.method,
  });
  late final String method;

  Paymentsss.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['method'] = method;
    return _data;
  }
}
