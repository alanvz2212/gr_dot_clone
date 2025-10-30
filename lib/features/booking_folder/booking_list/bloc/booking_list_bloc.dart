import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/booking_list/bloc/booking_list_event.dart';
import 'package:clone_green_dot/features/booking_folder/booking_list/bloc/booking_list_state.dart';
import 'package:clone_green_dot/features/booking_folder/booking_list/services/booking_list_service.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final BookingDetailsService bookingDetails;
  BookingDetailsBloc({required this.bookingDetails})
    : super(BookingDetailsInitial()) {
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
  }

  Future<void> _onFetchBookingDetails(
    FetchBookingDetailsEvent event,
    Emitter<BookingDetailsState> emit,
  ) async {
    emit(BookingDetailsLoading());
    try {
      final response = await bookingDetails.postBookingDetails(
        event.uId,
        event.bookId,
      );
      if (response.success) {
        emit(BookingDetailsLoaded(response.data));
      } else {
        emit(BookingDetailsError(response.message));
      }
    } catch (e) {
      emit(BookingDetailsError(e.toString()));
    }
  }
}
