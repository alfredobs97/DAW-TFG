import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider {
  static saveToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String> loadToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getString('token');
  }
}
