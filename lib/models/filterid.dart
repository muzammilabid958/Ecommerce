class filterid {
  late String id;
  late String price;

  filterid(this.id, this.price);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = id;
    _data['price'] = price;
    return _data;
  }
}
