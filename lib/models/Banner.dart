class Bannertext {
  Bannertext({
    required this.data,
  });
  late final Data data;
  Bannertext.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.mainText,
    required this.subText,
  });
  late final String mainText;
  late final String subText;
  Data.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    subText = json['sub_text'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main_text'] = mainText;
    _data['sub_text'] = subText;
    return _data;
  }
}
