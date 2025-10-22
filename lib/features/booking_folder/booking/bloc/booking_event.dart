import 'package:equatable/equatable.dart';
import 'package:clone_green_dot/features/booking_folder/booking/model/booking_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class SubmitBookingEvent extends BookingEvent {
  final int patientId;
  final String bookingDate;
  final String bookingTime;
  final String bookingEndTime;
  final int assignedTherapistId;
  final int? requestEmployeeId;
  final List<Service> services;

  const SubmitBookingEvent({
    required this.patientId,
    required this.bookingDate,
    required this.bookingTime,
    required this.bookingEndTime,
    required this.assignedTherapistId,
    this.requestEmployeeId,
    required this.services,
  });

  @override
  List<Object?> get props => [
    patientId,
    bookingDate,
    bookingTime,
    bookingEndTime,
    assignedTherapistId,
    requestEmployeeId,
    services,
  ];
}
