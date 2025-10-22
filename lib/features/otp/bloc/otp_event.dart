import 'package:equatable/equatable.dart';
import '../model/otp_models.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends OtpEvent {
  final OtpVerificationRequest request;

  const VerifyOtpEvent({required this.request});

  @override
  List<Object> get props => [request];
}