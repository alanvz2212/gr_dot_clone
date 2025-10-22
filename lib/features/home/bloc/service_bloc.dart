import 'package:flutter_bloc/flutter_bloc.dart';
import 'service_event.dart';
import 'service_state.dart';
import '../service/service_api.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceApi serviceApi;

  ServiceBloc({required this.serviceApi}) : super(ServiceInitial()) {
    on<FetchServicesEvent>(_onFetchServices);
  }

  Future<void> _onFetchServices(
    FetchServicesEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final response = await serviceApi.getServiceList();
      if (response.success) {
        emit(ServiceLoaded(response.data));
      } else {
        emit(ServiceError(response.message));
      }
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }
}
