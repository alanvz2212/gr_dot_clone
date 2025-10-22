import 'package:clone_green_dot/features/booking_folder/id_pass/service_list/model/service_list_model.dart';

abstract class ServiceListState {}

class ServiceListInitial extends ServiceListState {}

class ServiceListLoading extends ServiceListState {}

class ServiceListLoaded extends ServiceListState {
  final List<ServiceList> service;
  ServiceListLoaded(this.service);
}

class ServiceListError extends ServiceListState {
  final String message;
  ServiceListError(this.message);
}
