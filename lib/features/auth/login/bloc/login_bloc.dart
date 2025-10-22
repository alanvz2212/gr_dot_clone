import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../model/login_models.dart';
import '../service/login_service.dart';
import '../../../../utils/hive_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final loginRequest = LoginRequest(
        userName: event.email,
        password: event.password,
      );

      final response = await LoginService.login(loginRequest);

      if (response.success && response.data != null) {
        await HiveService.saveUserData(response.data!);

        emit(LoginSuccess(userData: response.data!, message: response.message));
      } else {
        emit(LoginFailure(error: response.message));
      }
    } catch (e) {
      emit(LoginFailure(error: 'An unexpected error occurred'));
    }
  }
}
