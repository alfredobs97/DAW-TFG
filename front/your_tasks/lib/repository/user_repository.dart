import 'dart:convert';
import 'dart:io';

import 'package:your_tasks/config/config.dart';
import 'package:your_tasks/models/user-model.dart';
import 'package:your_tasks/providers/token-provider.dart';

import 'package:http/http.dart' as http;

class UserRepository {
  List<User> users = [];
  List<User> copyUsersSearch = [];
  String endPoint = Config.getEndPoint() + 'login/';
  String endPointGetUsers = 'users';
  String token;

  UserRepository() {
    TokenProvider.loadToken().then((token) => this.token = token);
  }

  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(this.endPoint + endPointGetUsers, headers: {'Authorization': 'Bearer ${this.token}'});

    if (response.statusCode >= 500) {
      throw HttpException('Server error');
    }

    final List<dynamic> listOfUsers = json.decode(response.body);

    return listOfUsers.map((json) => User.fromMap(json)).toList();

    //this.users.length > 0 ? this._filterExistUsers(listOfUsers) : this._allUsers(listOfUsers);
  }

/*   List<User> filterExistUsers(String username, List<User> listOfUsers) {
    return listOfUsers.where((User user) => user.username.contains(username)).toList();
    /* listOfUsers.forEach((userJson) {
      final user = this.users.firstWhere((User user) => user.username == userJson['username'], orElse: () => null);

      if (user == null) this.users.add(User(username: userJson['username']));
    }); */
  } */

  List<User> usersSelected() {
    return this.users.where((User user) => user.isSelected).toList();
  }

  unselectUsers() {
    this.users.forEach((user) {
      user.isSelected = false;
    });
  }

  selectUsers(List<String> usernameOfUsersSelected) {
    if (this.users.length > 0) {
      usernameOfUsersSelected.forEach((usernameSelected) {
        this.users.firstWhere((user) => user.username == usernameSelected).isSelected = true;
      });
    } else {
      this.users = usernameOfUsersSelected.map((usernameSelected) => User(username: usernameSelected)).toList();
    }
  }

  copyOfUsersToSearch() {
    this.copyUsersSearch = [...this.users];
  }

  filterUsers(String username, List<User> users) {
    return users.where((user) => user.username.contains(username)).toList();
  }
}
