class ForgetPasswordOTP {
  String email;
  String otp;

  ForgetPasswordOTP(this.email, this.otp);
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class ForgetEmailOTP {
  String email;

  ForgetEmailOTP(this.email);

  Map<String, dynamic> toJson() => {'email': email};
}

class VerifyOTPModel {
  String email;
  String otp;
  VerifyOTPModel(this.email, this.otp);
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}
