import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_event.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_state.dart';
import 'package:clone_green_dot/features/profile/edit_profile/services/edit_profile_service.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileService editProfile;

  EditProfileBloc({required this.editProfile}) : super(EditProfileInitial()) {
    on<FetchEditProfileEvent>(_onFetchServices);
  }

  Future<void> _onFetchServices(
    FetchEditProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      final response = await editProfile.posteditProfile(event.userId);
      if (response.success) {
        emit(EditProfileLoaded(response.userList));
      } else {
        emit(EditProfileError(response.message));
      }
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
