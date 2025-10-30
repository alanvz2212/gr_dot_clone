abstract class BookingDetailsEvent {}

class FetchBookingDetailsEvent extends BookingDetailsEvent {
  final int uId;
  final int bookId;
  FetchBookingDetailsEvent({required this.uId, required this.bookId});
}
