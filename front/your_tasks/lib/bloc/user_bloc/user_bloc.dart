import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_tasks/models/user-model.dart';
import 'package:your_tasks/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();
  List<User> cacheUsers = [];
  List<User> usersSelected = [];

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUsers) yield* _mapFetchUsersState();
    if (event is FilterUsers) yield* _mapFilterUsersState(event.username);
    if (event is UsersSelected) yield* _mapUsersSelectedState(event.users);
    if (event is RemoveSelectedUser) yield* _mapRemoveUsersSelectedState(event.username);
    if(event is ClearSelectedUsers) yield* _mapClearUsersSelectedState();
  }

  Stream<UserState> _mapFetchUsersState() async* {
    yield FetchingUsers();
    try {
      final users = await _userRepository.fetchUsers();
      this.cacheUsers = users;
      yield UsersLoaded(users);
    } catch (e) {
      yield ErrorFetchingUsers();
    }
  }

  Stream<UserState> _mapFilterUsersState(String username) async* {
    final users = _userRepository.filterUsers(username, [...cacheUsers]);
    yield UsersLoaded(users);
  }

  Stream<UserState> _mapUsersSelectedState(List<User> users) async* {
    this.usersSelected = users;
    yield UsersAsigned(this.usersSelected);
  }

  Stream<UserState> _mapRemoveUsersSelectedState(String username) async* {
    this.usersSelected.removeWhere((user) => user.username == username);
    yield UsersAsigned(this.usersSelected);
  }

  Stream<UserState> _mapClearUsersSelectedState() async* {
    this.usersSelected = [];
    yield UsersCleared();
  }
}
