part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LogginIn extends LoginState{}

class Logged extends LoginState{
  final String token;
  final String username;

  Logged(this.token, this.username);

}

class InvalidLogin extends LoginState{}
