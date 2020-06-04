part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class Registring extends RegisterState{}

class Registered extends RegisterState {}

class ErrorRegistered extends RegisterState {}
