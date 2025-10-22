import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String message;
  const BookingSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class BookingError extends BookingState {
  final String error;
  const BookingError({required this.error});
  @override
  List<Object> get props => [error];
}
