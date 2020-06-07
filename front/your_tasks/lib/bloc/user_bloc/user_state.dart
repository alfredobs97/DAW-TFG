part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class FetchingUsers extends UserState {}

class ErrorFetchingUsers extends UserState {}

class UsersLoaded extends UserState{
  final List<User> users;

  UsersLoaded(this.users);
}

class UsersAsigned extends UserState {
  final List<User> users;

  UsersAsigned(this.users);
}

class UsersCleared extends UserState{}
