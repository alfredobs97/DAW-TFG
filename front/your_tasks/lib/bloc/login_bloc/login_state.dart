part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LogginIn extends LoginState{}

class Logged extends LoginState{
  final String token;

  Logged(this.token);
}

class InvalidLogin extends LoginState{}
