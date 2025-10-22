import 'package:equatable/equatable.dart';
import '../model/customer_registration_models.dart';

abstract class CustomerRegistrationEvent extends Equatable {
  const CustomerRegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterCustomerEvent extends CustomerRegistrationEvent {
  final CustomerRegistrationRequest request;

  const RegisterCustomerEvent({required this.request});

  @override
  List<Object> get props => [request];
}
