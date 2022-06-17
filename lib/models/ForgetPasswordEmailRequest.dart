class ForgetPasswordEmailRequest {
  ForgetPasswordEmailRequest({
    required this.status,
    required this.message,
  });
  late final String status;
  late final String message;

  ForgetPasswordEmailRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}
