import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/otp_service.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpService _service;

  OtpBloc({OtpService? service})
      : _service = service ?? OtpService(),
        super(OtpInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());

    try {
      final response = await _service.verifyOtp(event.request);
      emit(OtpVerificationSuccess(response: response));
    } catch (e) {
      emit(OtpVerificationFailure(error: e.toString()));
    }
  }
}