class AddToCartModel {
  AddToCartModel({
    required this.productId,
    required this.quantity,
  });
  late final String productId;
  late final String quantity;

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    return _data;
  }
}
