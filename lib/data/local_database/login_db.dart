import 'package:shared_preferences/shared_preferences.dart';

class UserInfoDB {
  //storing user email
  static storeUserEmail(String email) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString("email", email);
  }

//getting user email
  static getUserEmail(String email) async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString("email");
  }

//storing user token
  static storeUserToken(String email, String token) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString(email, token);
    storeUserEmail(email);
  }

//getting user token
  static getUserToken(String email) async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString(email);
  }

  //storing user joining date and id
  static storeUserJoiningData(String id, String date) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString("id", id);
    instance.setString("date", date);
  }

//getting user joining date
  static getUserJoiningDate() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString("date");
  }

  //getting user  id
  static getUserEmployeeIDData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString("id");
  }
}
