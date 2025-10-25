import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/bloc/assigned_therapist_list_event.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/bloc/assigned_therapist_list_state.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/services/assigned_therapist_list_service.dart';

class AssignedTherapistListBloc
    extends Bloc<AssignedTherapistListEvent, AssignedTherapistListState> {
  final AssignedTherapistListService assignedTherapistListService;
  AssignedTherapistListBloc({required this.assignedTherapistListService})
    : super(AssignedTherapistListInitial()) {
    on<FetchAssignedTherapistListEvent>(_onFetchAssignedTherapistList);
  }
  Future<void> _onFetchAssignedTherapistList(
    FetchAssignedTherapistListEvent event,
    Emitter<AssignedTherapistListState> emit,
  ) async {
    emit(AssignedTherapistListLoading());
    try {
      final response = await assignedTherapistListService
          .getAssignedTherapistList();
      if (response.success && response.data.isNotEmpty) {
        emit(AssignedTherapistListLoaded(response.data));
      } else if (response.data.isNotEmpty) {
        emit(AssignedTherapistListLoaded(response.data));
      } else {
        emit(AssignedTherapistListError(response.message.isNotEmpty ? response.message : 'No therapists available'));
      }
    } catch (e) {
      print('BLoC Error: $e');
      emit(AssignedTherapistListError(e.toString()));
    }
  }
}
