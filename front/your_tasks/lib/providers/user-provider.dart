import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:your_tasks/config/config.dart';

import 'package:your_tasks/models/user-model.dart';
import 'package:your_tasks/providers/token-provider.dart';

class UserProvider {
  List<User> users = [];
  List<User> copyUsersSearch = [];
  String endPoint = Config.getEndPoint() + 'login/';
  String endPointGetUsers = 'users';
  String token;

  Future<void> fetchUsers() async {
    this.token = await TokenProvicer.loadToken();
    final response = await http.get(this.endPoint + endPointGetUsers,
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode >= 500) {
      throw HttpException('Server error');
    }

    final List<dynamic> listOfUsers = json.decode(response.body);

    this.users.length > 0
        ? this._filterExistUsers(listOfUsers)
        : this._allUsers(listOfUsers);
  }

  _allUsers(List<dynamic> listOfUsers) {
    this.users =
        listOfUsers.map((json) => User(username: json['username'])).toList();
  }

  _filterExistUsers(List<dynamic> listOfUsers) {
    listOfUsers.forEach((userJson) {
      final user = this.users.firstWhere(
          (User user) => user.username == userJson['username'],
          orElse: () => null);

      if (user == null) this.users.add(User(username: userJson['username']));
    });
  }

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
        this
            .users
            .firstWhere((user) => user.username == usernameSelected)
            .isSelected = true;
      });
    } else {
      this.users = usernameOfUsersSelected
          .map((usernameSelected) => User(username: usernameSelected))
          .toList();
    }
  }

  copyOfUsersToSearch() {
    this.copyUsersSearch = [...this.users];
  }

  filterUsers(String username) {
    this.copyUsersSearch = this
        .copyUsersSearch
        .where((user) => user.username.contains(username))
        .toList();
  }
}
