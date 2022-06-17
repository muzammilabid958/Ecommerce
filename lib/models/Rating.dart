class Rating {
  String rating;
  String title;
  String comment;
  Rating(this.rating, this.title, this.comment);
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rating'] = rating;
    _data['title'] = title;
    _data['comment'] = comment;
    return _data;
  }
}
