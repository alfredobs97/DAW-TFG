import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks/providers/user-provider.dart';

class AddUserTask extends StatefulWidget {
  @override
  _AddUserTaskState createState() => _AddUserTaskState();
}

class _AddUserTaskState extends State<AddUserTask> {
  bool isSearching = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserProvider>(context).fetchUsers().then((value) {
      setState(() {});
    });
  }

  _listViewSearching(UserProvider userProvider) {
    return ListView.builder(
      itemCount: userProvider.copyUsersSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(userProvider.copyUsersSearch[index].username),
          value: userProvider.copyUsersSearch[index].isSelected,
          onChanged: (bool newValue) {
            userProvider.copyUsersSearch[index].isSelected = newValue;

            // todo rethink this
            userProvider.users
                .firstWhere((user) =>
                    userProvider.copyUsersSearch[index].username ==
                    user.username)
                .isSelected = newValue;
            setState(() {});
          },
        );
      },
    );
  }

  _listViewFetch(userProvider) {
    return ListView.builder(
      itemCount: userProvider.users.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(userProvider.users[index].username),
          value: userProvider.users[index].isSelected,
          onChanged: (bool newValue) {
            userProvider.users[index].isSelected = newValue;
            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca los usuarios'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) {
              isSearching = value.length > 0;

              if (value.length == 0) userProvider.copyOfUsersToSearch();

              if (isSearching) userProvider.filterUsers(value);

              setState(() {});
            },
            decoration: InputDecoration(
                icon: Icon(Icons.search), hintText: 'Nombre de usuario'),
          ),
          Expanded(
              child: isSearching
                  ? _listViewSearching(userProvider)
                  : _listViewFetch(userProvider))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, userProvider.usersSelected());
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
