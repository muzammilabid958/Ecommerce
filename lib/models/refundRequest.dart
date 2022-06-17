class RefundRequest {
  RefundRequest(
      {required this.orderNo,
      required this.reason,
      required this.productId,
      required this.qty});
  late final String orderNo;
  late final String reason;
  late final List<int> productId;
  late final List<int> qty;

  RefundRequest.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    reason = json['reason'];
    productId = List.castFrom<dynamic, int>(json['product_id']);
    qty = List.castFrom<dynamic, int>(json['qty']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_no'] = orderNo;
    _data['reason'] = reason;
    _data['product_id'] = productId;
    _data['qty'] = qty;
    return _data;
  }
}
