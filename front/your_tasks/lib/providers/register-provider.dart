import 'dart:io';

import 'package:your_tasks/providers/login-provider.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends LoginProvider {
  String name;
  int tel;

  registerCredentials(String username, String name, String pass, int number) {
    super.addCredentials(username, pass);
    this.name = name;
    this.tel = number;
  }

  register() async{
    final response = await http.post(super.endPoint + 'login/createUser', body: {
      'username': super.username,
      'name': name,
      'pass': super.password,
      'tel': tel.toString()
    });

    if (response.statusCode >= 500) {
      throw HttpException('Server Error');
    }


  }
}
