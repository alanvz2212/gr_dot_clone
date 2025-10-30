import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:clone_green_dot/features/profile/update_profile/bloc/update_profile_event.dart';
import 'package:clone_green_dot/features/profile/update_profile/bloc/update_profile_state.dart';
import 'package:clone_green_dot/features/profile/update_profile/model/update_profile_model.dart';
import 'package:clone_green_dot/features/profile/update_profile/services/update_profile_service.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  static final logger = Logger();

  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<SubmitUpdateProfileEvent>(_onSubmitUpdateProfile);
  }
  Future<void> _onSubmitUpdateProfile(
    SubmitUpdateProfileEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    logger.i('SubmitUpdateProfileEvent triggered');
    emit(UpdateProfileLoading());
    logger.i('Emitted UpdateProfileLoading state');

    try {
      final request = UpdateProfileModelRequest(
        patientId: event.patientId,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        countryCode: event.countryCode,
        email: event.email,
        password: event.password,
        gender: event.gender,
      );
      logger.i(
        'Created UpdateProfileModelRequest with patientId: ${event.patientId}',
      );

      final response = await UpdateProfileService.updateProfile(request);
      logger.i(
        'Received response - success: ${response.success}, message: ${response.message}',
      );

      if (response.success) {
        logger.i('Emitting UpdateProfileSuccess state');
        emit(UpdateProfileSuccess(message: 'Thank you for Update Profile!'));
      } else {
        logger.w(
          'Emitting UpdateProfileError state with message: ${response.message}',
        );
        emit(UpdateProfileError(error: response.message));
      }
    } catch (e) {
      logger.e('Exception in _onSubmitUpdateProfile: $e');
      emit(UpdateProfileError(error: 'Failed to Update Profile: $e'));
    }
  }
}
