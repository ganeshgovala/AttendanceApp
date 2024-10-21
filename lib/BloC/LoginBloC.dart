// Events
// ignore_for_file: unused_local_variable

import 'package:attendance/auth/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvent{}
class CheckLoginEvent extends LoginEvent{
  final String email;
  final String password;
  CheckLoginEvent({required this.email, required this.password});
}

// States
abstract class LoginState{}
class InitialLoginState extends LoginState{}
class LoadingLoginState extends LoginState{}
class LoadedLoginState extends LoginState{
  final String result;
  LoadedLoginState(this.result);
}
class ErrorLoginState extends LoginState{}

// Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthService _auth = AuthService();

  LoginBloc() : super(InitialLoginState()) {
    on<CheckLoginEvent>((event, emit) async {
      emit(LoadingLoginState());
      try {
        await _auth.login(email: event.email, password: event.password);
        final result = 'Valid';
        emit(LoadedLoginState(result));
      }
      on FirebaseAuthException catch(err) {
        final String result = err.code;
        print(result);
        emit(LoadedLoginState(result));
      }
    });
  }
}