class widgetjson {
  widgetjson({
    required this.banner,
  });
  late final List<Banner> banner;

  widgetjson.fromJson(Map<String, dynamic> json) {
    banner = List.from(json['banner']).map((e) => Banner.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banner'] = banner.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Banner {
  Banner(
      {required this.title,
      required this.boxcolor,
      required this.description,
      required this.fontsize,
      required this.cardcolor1,
      required this.cardcolor2,
      required this.cardcolor3,
      required this.fontcolor,
      required this.buttoncolor,
      required this.homenavbarcolour,
      required this.bannertextcolor,
      required this.bannertextbordercolor,
      required this.fontstyle,
      required this.bodyText1,
      required this.bodyText2,
      required this.textcolor1,
      required this.textcolour2,
      required this.scaffoldBackgroundColor,
      required this.appbarbackgroundcolor,
      required this.appbarbackgroundIconcolor,
      required this.appbartitleColor,
      required this.iscardenable,
      required this.isbannerenable,
      required this.isfeatureenable,
      required this.textColor,
      required this.bottomBarColor,
      required this.primaryColor,
      required this.LinearGradientSliderColor,
      required this.loadercolor,
      required this.iconColor});

  late final String title;
  late final String boxcolor;
  late final String description;
  late final int fontsize;
  late final String cardcolor1;
  late final String cardcolor2;
  late final String cardcolor3;
  late final String fontcolor;
  late final String buttoncolor;
  late final String homenavbarcolour;
  late final String bannertextcolor;
  late final String bannertextbordercolor;
  late final String fontstyle;
  late final String bodyText1;
  late final String bodyText2;
  late final String textcolor1;
  late final String textcolour2;
  late final String scaffoldBackgroundColor;
  late final String appbarbackgroundcolor;
  late final String appbarbackgroundIconcolor;
  late final String appbartitleColor;
  late final bool iscardenable;
  late final bool isbannerenable;
  late final bool isfeatureenable;
  late final String textColor;
  late final String bottomBarColor;
  late final String primaryColor;
  late final String LinearGradientSliderColor;
  late final String loadercolor;
  late final String CashBackColor;
  late final String iconColor;

  Banner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    boxcolor = json['boxcolor'];
    description = json['description'];
    fontsize = json['fontsize'];
    cardcolor1 = json['cardcolor1'];
    cardcolor2 = json['cardcolor2'];
    cardcolor3 = json['cardcolor3'];
    fontcolor = json['fontcolor'];
    buttoncolor = json['buttoncolor'];
    homenavbarcolour = json['homenavbarcolour'];
    bannertextcolor = json['bannertextcolor'];
    bannertextbordercolor = json['bannertextbordercolor'];
    fontstyle = json['fontstyle'];
    bodyText1 = json['bodyText1'];
    bodyText2 = json['bodyText2'];
    textcolor1 = json['textcolor1'];
    textcolour2 = json['textcolour2'];
    scaffoldBackgroundColor = json['scaffold_background_color'];
    appbarbackgroundcolor = json['appbarbackgroundcolor'];
    appbarbackgroundIconcolor = json['appbarbackgroundIconcolor'];
    appbartitleColor = json['appbartitleColor'];
    iscardenable = json['iscardenable'];
    isbannerenable = json['isbannerenable'];
    isfeatureenable = json['isfeatureenable'];
    textColor = json['text_color'];
    bottomBarColor = json['bottomBarColor'];
    primaryColor = json['primary_color'];
    LinearGradientSliderColor = json['LinearGradientSliderColor'];
    loadercolor = json['loadercolor'];
    CashBackColor = json['CashBackColor'];
    iconColor = json['iconColor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['boxcolor'] = boxcolor;
    _data['description'] = description;
    _data['fontsize'] = fontsize;
    _data['cardcolor1'] = cardcolor1;
    _data['cardcolor2'] = cardcolor2;
    _data['cardcolor3'] = cardcolor3;
    _data['fontcolor'] = fontcolor;
    _data['buttoncolor'] = buttoncolor;
    _data['homenavbarcolour'] = homenavbarcolour;
    _data['bannertextcolor'] = bannertextcolor;
    _data['bannertextbordercolor'] = bannertextbordercolor;
    _data['fontstyle'] = fontstyle;
    _data['bodyText1'] = bodyText1;
    _data['bodyText2'] = bodyText2;
    _data['textcolor1'] = textcolor1;
    _data['textcolour2'] = textcolour2;
    _data['scaffold_background_color'] = scaffoldBackgroundColor;
    _data['appbarbackgroundcolor'] = appbarbackgroundcolor;
    _data['appbarbackgroundIconcolor'] = appbarbackgroundIconcolor;
    _data['appbartitleColor'] = appbartitleColor;
    _data['iscardenable'] = iscardenable;
    _data['isbannerenable'] = isbannerenable;
    _data['isfeatureenable'] = isfeatureenable;
    _data['text_color'] = textColor;
    _data['bottomBarColor'] = bottomBarColor;
    _data['primary_color'] = primaryColor;
    _data['LinearGradientSliderColor'] = LinearGradientSliderColor;
    _data['loadercolor'] = loadercolor;
    _data['CashBackColor'] = CashBackColor;
    _data['iconColor'] = iconColor;
    return _data;
  }
}
