import 'dart:io';

import 'package:your_tasks/repository/login_repository.dart';
import 'package:http/http.dart' as http;

class RegisterRepository extends LoginRepository {
  register({String username, String name, String password, int tel}) async {
    final response = await http.post(super.endPoint + 'login/createUser',
        body: {'username': username, 'name': name, 'pass': password, 'tel': tel.toString()});

    if (response.statusCode >= 500) {
      throw HttpException('Server Error');
    }
  }
}
