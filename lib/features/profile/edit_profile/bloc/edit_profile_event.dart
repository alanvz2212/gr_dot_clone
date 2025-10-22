abstract class EditProfileEvent {}

class FetchEditProfileEvent extends EditProfileEvent {
  final int userId;

  FetchEditProfileEvent({required this.userId});
}
