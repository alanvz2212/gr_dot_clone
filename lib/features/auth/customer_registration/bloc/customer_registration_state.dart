import 'package:equatable/equatable.dart';
import '../model/customer_registration_models.dart';

abstract class CustomerRegistrationState extends Equatable {
  const CustomerRegistrationState();

  @override
  List<Object> get props => [];
}

class CustomerRegistrationInitial extends CustomerRegistrationState {}

class CustomerRegistrationLoading extends CustomerRegistrationState {}

class CustomerRegistrationSuccess extends CustomerRegistrationState {
  final CustomerRegistrationResponse response;

  const CustomerRegistrationSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class CustomerRegistrationFailure extends CustomerRegistrationState {
  final String error;

  const CustomerRegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
