import 'package:equatable/equatable.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class SubmitUpdateProfileEvent extends UpdateProfileEvent {
  final int patientId;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String countryCode;
  final int gender;

  const SubmitUpdateProfileEvent({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.gender,
  });

  @override
  List<Object?> get props => [
    patientId,
    firstName,
    lastName,
    phone,
    email,
    password,
    countryCode,
    gender,
  ];
}
