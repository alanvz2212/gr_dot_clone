import 'package:clone_green_dot/features/booking_folder/booking_list/model/booking_list_model.dart';

abstract class BookingDetailsState {}

class BookingDetailsInitial extends BookingDetailsState {}

class BookingDetailsLoading extends BookingDetailsState {}

class BookingDetailsLoaded extends BookingDetailsState {
  final BookingData? data;
  BookingDetailsLoaded(this.data);
}

class BookingDetailsError extends BookingDetailsState {
  final String message;
  BookingDetailsError(this.message);
}
