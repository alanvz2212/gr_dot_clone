import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/service_list/bloc/service_list_event.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/service_list/bloc/service_list_state.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/service_list/service/service_list_service.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {
  final ServiceListService serviceListService;

  ServiceListBloc({required this.serviceListService})
    : super(ServiceListInitial()) {
    on<FetchServiceListEvent>(_onFetchServiceList);
  }
  Future<void> _onFetchServiceList(
    FetchServiceListEvent event,
    Emitter<ServiceListState> emit,
  ) async {
    emit(ServiceListLoading());
    try {
      final response = await serviceListService.getServiceList();
      if (response.success) {
        emit(ServiceListLoaded(response.data));
      } else {
        emit(ServiceListLoaded(response.data));
      }
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }
}
