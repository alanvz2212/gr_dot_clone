import 'package:equatable/equatable.dart';
import 'package:clone_green_dot/features/profile/update_profile/model/update_profile_model.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final UpdateProfileModelResponse response;

  const UpdateProfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class UpdateProfileFailure extends UpdateProfileState {
  final String error;

  const UpdateProfileFailure({required this.error});

  @override
  List<Object> get props => [error];
}
