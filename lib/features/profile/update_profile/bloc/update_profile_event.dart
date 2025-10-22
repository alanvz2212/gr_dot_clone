import 'package:equatable/equatable.dart';
import 'package:clone_green_dot/features/profile/update_profile/model/update_profile_model.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class RegisterUpdateProfileEvent extends UpdateProfileEvent {
  final UpdateProfileModelRequest request;

  const RegisterUpdateProfileEvent({required this.request});

  @override
  List<Object> get props => [request];
}
