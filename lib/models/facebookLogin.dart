class FacebookLoginModel {
  late String email;
  late String first_name;
  late String last_name;
  late String is_social;
  late String facebook_id;

  FacebookLoginModel(this.email, this.first_name, this.last_name,
      this.is_social, this.facebook_id);

  Map toJson() => {
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'is_social': is_social,
        'facebook_id': facebook_id
      };

  FacebookLoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];

    is_social = json['is_social'];
    facebook_id = json['facebook_id'];
  }
}
