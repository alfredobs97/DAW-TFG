import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_tasks/repository/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerRepository = RegisterRepository();
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is Register) yield* _mapRegisterToState(event.username, event.name, event.password, event.phone);
  }

  Stream<RegisterState> _mapRegisterToState(String username, String name, String password, int phone) async* {
    yield Registring();
    try {
      await _registerRepository.register(username: username, name: name, password: password, tel: phone);
      yield Registered();
    } catch (e) {
      yield ErrorRegistered();
    }
  }
}
