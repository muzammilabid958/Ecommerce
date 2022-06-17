class ConfigPages {
  ConfigPages({
    required this.data,
  });
  late final List<Data> data;
  
  ConfigPages.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.PageName,
    required this.PageContent,
    required this.urlSlug,
    required this.isDeleteable,
  });
  late final int id;
  late final String PageName;
  late final String PageContent;
  late final String urlSlug;
  late final int isDeleteable;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    PageName = json['PageName'];
    PageContent = json['PageContent'];
    urlSlug = json['url_slug'];
    isDeleteable = json['is_deleteable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['PageName'] = PageName;
    _data['PageContent'] = PageContent;
    _data['url_slug'] = urlSlug;
    _data['is_deleteable'] = isDeleteable;
    return _data;
  }
}