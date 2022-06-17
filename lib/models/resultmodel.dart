class ResultModel {
  ResultModel({
    required this.token,
    required this.message,
    required this.data,
  });
  late final bool token;
  late final String message;
  late final Data data;

  ResultModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.gender,
    this.dateOfBirth,
    required this.phone,
    required this.status,
    required this.group,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String gender;
  late final Null dateOfBirth;
  late final String phone;
  late final int status;
  late final Group group;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = null;
    phone = json['phone'];
    status = json['status'];
    // group = Group.fromJson(json['group']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['name'] = name;
    _data['gender'] = gender;
    _data['date_of_birth'] = dateOfBirth;
    _data['phone'] = phone;
    _data['status'] = status;
    _data['group'] = group.toJson();
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Group {
  Group({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String name;
  late final Null createdAt;
  late final Null updatedAt;

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
