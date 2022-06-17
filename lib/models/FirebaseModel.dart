class FirebaseModel {
  late String slider_is;
  late String values;

  FirebaseModel({
    required this.slider_is,
    required this.values,
  });
  FirebaseModel.fromJson(Map<String, dynamic> parsedJson) {
    slider_is = parsedJson['slider_is'].toString();
    values = parsedJson['values'].toString();
  }

  set setObject(FirebaseModel firebaseModel) {
    this.slider_is = firebaseModel.slider_is;
    this.values = firebaseModel.values;
  }
}
