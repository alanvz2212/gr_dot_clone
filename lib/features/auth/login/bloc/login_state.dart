import '../model/login_models.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserData userData;
  final String message;

  LoginSuccess({
    required this.userData,
    required this.message,
  });
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}