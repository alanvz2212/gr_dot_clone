import '../model/employee_schedule_model.dart';

abstract class EmployeeScheduleState {}

class EmployeeScheduleInitial extends EmployeeScheduleState {}

class EmployeeScheduleLoading extends EmployeeScheduleState {}

class EmployeeScheduleLoaded extends EmployeeScheduleState {
  final List<EmployeeSchedule> employees;

  EmployeeScheduleLoaded(this.employees);
}

class EmployeeScheduleError extends EmployeeScheduleState {
  final String message;

  EmployeeScheduleError(this.message);
}
