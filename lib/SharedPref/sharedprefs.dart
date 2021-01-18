import 'package:NeoStore/models/login_response.dart';
import 'package:NeoStore/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  setUser(Data data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fname', data.firstName);
    prefs.setString('lname', data.lastName);
    prefs.setString('email', data.email);
    prefs.setString('access_token', data.accessToken);
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return User(
      fname: prefs.getString('fname'),
      lname: prefs.getString('lname'),
      email: prefs.getString('email'),
      accessToken: prefs.getString('access_token'),
    );
  }
  clear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}