
// import 'dart:convert';

import 'dart:convert';

User loginfromjson(String str) => User.fromJson(jsonDecode(str));

String logintojson (User data) => json.encode(data.toJson());

// class LoginRequestModel {
  

// LoginRequestModel({
// required this.email,
// required this.password,
// });
// late final String email;
// late final String password;

//  LoginRequestModel.fromJson(Map<String, dynamic> json){
  
//   email = json['email'];
//   password = json['password'];

// }


// }




// }
class User {
  final String email;
  final String password;

  User(this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
    : email = json['email'],
        password = json['password'];

Map <String,dynamic> toJson(){
  final _data = <String, dynamic>{};
  _data['email'] = email;
  _data['password'] = password;

  return _data;}
      }
