import 'dart:io';

import '../config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../exceptions/invalid-login.dart';

class LoginRepository {
  final String endPoint = Config.getEndPoint();

  Future<String> login(String username, String password) async {
    final response = await http.post(endPoint + 'login', body: {'username': username, 'pass': password});

    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw LoginInvalidException();
    }

    if (response.statusCode >= 500) {
      throw HttpException('Server Error');
    }

    return json.decode(response.body)['access_token'];
  }
}
