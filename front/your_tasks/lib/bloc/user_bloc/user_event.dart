part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class FilterUsers extends UserEvent {
  final String username;

  FilterUsers(this.username);
}

class UsersSelected extends UserEvent{
  final List<User> users;

  UsersSelected(this.users);
}

class RemoveSelectedUser extends UserEvent{
  final String username;

  RemoveSelectedUser(this.username);
}

class ClearSelectedUsers extends UserEvent{}
