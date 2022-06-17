

class MessageModel {
  MessageModel({
    required this.message,
  });
  late final String message;
  
  MessageModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}








// class MessageModel{

// String message;

// MessageModel(
// {
//   required this.message
// });

// Map <String, dynamic> toJson(){
// return{
//   "message":message
// };
// }

// }