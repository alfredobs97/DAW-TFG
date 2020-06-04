import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_tasks/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginRepository = LoginRepository();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) yield* _mapLoginToState(event.username, event.password);
  }

  Stream<LoginState> _mapLoginToState(String username, String password) async* {
    yield LogginIn();
    try {
      final token = await _loginRepository.login(username, password);
      yield Logged(token);
    } catch (e) {
      yield InvalidLogin();
    }
  }
}
