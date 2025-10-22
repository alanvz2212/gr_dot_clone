import 'package:clone_green_dot/features/profile/edit_profile/model/edit_profile_model.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final List<User> users;

  EditProfileLoaded(this.users);
}

class EditProfileError extends EditProfileState {
  final String message;

  EditProfileError(this.message);
}
