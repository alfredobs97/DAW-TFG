import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/bloc/user_bloc/user_bloc.dart';
import 'package:your_tasks/models/user-model.dart';

class AddUserTask extends StatefulWidget {
  @override
  _AddUserTaskState createState() => _AddUserTaskState();
}

class _AddUserTaskState extends State<AddUserTask> {
  List<User> _userSelected = [];

  _listViewFetch(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(users[index].username),
          value: _userSelected.any((User user) => users[index].username == user.username),
          onChanged: (bool isSelected) {
            users[index].isSelected = isSelected;
            isSelected ? _userSelected.add(users[index]) : _userSelected.remove(users[index]);
            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca los usuarios'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String username) {
              if (username.length == 0) context.bloc<UserBloc>().add(FetchUsers());

              if (username.length > 1) context.bloc<UserBloc>().add(FilterUsers(username));
            },
            decoration: InputDecoration(
                icon: Icon(Icons.search), hintText: 'Nombre de usuario'),
          ),
          Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if(state is UsersLoaded) return _listViewFetch(state.users);
                  if(state is FetchingUsers) return Center(child: CircularProgressIndicator());
                  if(state is ErrorFetchingUsers) return Center(child: Text('Error en el servidor'));
                  return Center(child: CircularProgressIndicator());
                },
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.bloc<UserBloc>().add(UsersSelected(_userSelected));
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
