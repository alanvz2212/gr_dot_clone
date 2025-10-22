import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/customer_registration_service.dart';
import 'customer_registration_event.dart';
import 'customer_registration_state.dart';

class CustomerRegistrationBloc
    extends Bloc<CustomerRegistrationEvent, CustomerRegistrationState> {
  final CustomerRegistrationService _service;

  CustomerRegistrationBloc({CustomerRegistrationService? service})
    : _service = service ?? CustomerRegistrationService(),
      super(CustomerRegistrationInitial()) {
    on<RegisterCustomerEvent>(_onRegisterCustomer);
  }

  Future<void> _onRegisterCustomer(
    RegisterCustomerEvent event,
    Emitter<CustomerRegistrationState> emit,
  ) async {
    emit(CustomerRegistrationLoading());

    try {
      final response = await _service.registerCustomer(event.request);
      emit(CustomerRegistrationSuccess(response: response));
    } catch (e) {
      emit(CustomerRegistrationFailure(error: e.toString()));
    }
  }
}
