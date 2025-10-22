import 'package:equatable/equatable.dart';
import '../model/otp_models.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpVerificationSuccess extends OtpState {
  final OtpVerificationResponse response;

  const OtpVerificationSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class OtpVerificationFailure extends OtpState {
  final String error;

  const OtpVerificationFailure({required this.error});

  @override
  List<Object> get props => [error];
}