import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:your_tasks/config/config.dart';
import 'package:your_tasks/exceptions/invalid-login.dart';

class LoginProvider{
  final String endPoint = Config.getEndPoint();
  String username;
  String password;
  String token;

  //LoginProvider({this.username, this.password});

  addCredentials(String username, String pass){
    this.username = username;
    this.password = pass;
  }


  login() async{
    final response = await http.post(endPoint + 'login', body: {'username': username, 'pass': password});


    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw LoginInvalidException();
    }

    if (response.statusCode >= 500) {
      throw HttpException('Server Error');
    }


    token = json.decode(response.body)['access_token'];

    return token;
  } 

}