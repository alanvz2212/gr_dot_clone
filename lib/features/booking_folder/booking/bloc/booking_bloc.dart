import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_event.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_state.dart';
import 'package:clone_green_dot/features/booking_folder/booking/model/booking_model.dart';
import 'package:clone_green_dot/features/booking_folder/booking/services/booking_service.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SubmitBookingEvent>(_onSubmitBooking);
  }
  Future<void> _onSubmitBooking(
    SubmitBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final request = BookingRequest(
        patientId: event.patientId,
        bookingDate: event.bookingDate,
        bookingTime: event.bookingTime,
        bookingEndTime: event.bookingEndTime,
        assignedTherapistId: event.assignedTherapistId,
        requestEmployeeId: event.requestEmployeeId,
        services: event.services,
      );
      final response = await BookingService.submitBooking(request);
      if (response.success) {
        emit(BookingSuccess(message: 'Thank you for your booking!'));
      } else {
        emit(BookingError(error: response.message));
      }
    } catch (e) {
      emit(BookingError(error: 'Failed to submit booking: $e'));
    }
  }
}
