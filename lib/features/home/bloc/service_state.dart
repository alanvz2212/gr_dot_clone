import '../model/service_model.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceData> services;

  ServiceLoaded(this.services);
}

class ServiceError extends ServiceState {
  final String message;

  ServiceError(this.message);
}
