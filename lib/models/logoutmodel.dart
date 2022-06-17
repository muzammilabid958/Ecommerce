

class LogoutModel{

String message;

LogoutModel(
{
  required this.message
});

Map <String, dynamic> toJson(){
return{
  "message":message
};
}

}