import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/profile/update_profile/bloc/update_profile_event.dart';
import 'package:clone_green_dot/features/profile/update_profile/bloc/update_profile_state.dart';
import 'package:clone_green_dot/features/profile/update_profile/services/update_profile_service.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileService _service;

  UpdateProfileBloc({UpdateProfileService? service})
    : _service = service ?? UpdateProfileService(),
      super(UpdateProfileInitial()) {
    on<RegisterUpdateProfileEvent>(_onRegisterUpdateProfile);
  }

  Future<void> _onRegisterUpdateProfile(
    RegisterUpdateProfileEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());

    try {
      final response = await _service.updateProfile(event.request);
      emit(UpdateProfileSuccess(response: response));
    } catch (e) {
      emit(UpdateProfileFailure(error: e.toString()));
    }
  }
}
