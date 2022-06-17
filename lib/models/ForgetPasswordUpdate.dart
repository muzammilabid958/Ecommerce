class ForgetPasswordUpdateModel {
  String email;
  String password;

  ForgetPasswordUpdateModel(this.email, this.password);
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
