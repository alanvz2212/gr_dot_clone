import 'package:equatable/equatable.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String message;
  const UpdateProfileSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class UpdateProfileError extends UpdateProfileState {
  final String error;
  const UpdateProfileError({required this.error});
  @override
  List<Object> get props => [error];
}
