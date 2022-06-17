import 'package:shared_preferences/shared_preferences.dart';

class GetPasswordChangeDeatils{
  
   String? token;
  
   String? email;
 

  GetPasswordChangeDeatils(token,email){
    this.token=token;

    this.email=email;

  }


static Future<GetPasswordChangeDeatils> getusers() async {

SharedPreferences pref= await SharedPreferences.getInstance();

  return GetPasswordChangeDeatils(pref.getString("loggedIntoken").toString(),pref.getString("email").toString());

}


}