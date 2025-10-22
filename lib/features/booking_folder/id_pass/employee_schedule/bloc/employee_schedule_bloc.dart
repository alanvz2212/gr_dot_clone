import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_schedule_event.dart';
import 'employee_schedule_state.dart';
import '../service/employee_schedule_service.dart';

class EmployeeScheduleBloc extends Bloc<EmployeeScheduleEvent, EmployeeScheduleState> {
  final EmployeeScheduleService employeeScheduleService;

  EmployeeScheduleBloc({required this.employeeScheduleService}) : super(EmployeeScheduleInitial()) {
    on<FetchEmployeeScheduleEvent>(_onFetchEmployeeSchedule);
  }

  Future<void> _onFetchEmployeeSchedule(
    FetchEmployeeScheduleEvent event,
    Emitter<EmployeeScheduleState> emit,
  ) async {
    emit(EmployeeScheduleLoading());
    try {
      final response = await employeeScheduleService.getEmployeeSchedule();
      if (response.success) {
        emit(EmployeeScheduleLoaded(response.data));
      } else {
        emit(EmployeeScheduleError(response.message));
      }
    } catch (e) {
      emit(EmployeeScheduleError(e.toString()));
    }
  }
}
