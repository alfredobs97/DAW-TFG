part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class Register extends RegisterEvent{
  final String username;
  final String name;
  final String password;
  final int phone;

  Register({this.username, this.name, this.password, this.phone});
}
