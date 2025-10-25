import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/model/assigned_therapist_list_model.dart';

abstract class AssignedTherapistListState {}

class AssignedTherapistListInitial extends AssignedTherapistListState {}

class AssignedTherapistListLoading extends AssignedTherapistListState {}

class AssignedTherapistListLoaded extends AssignedTherapistListState {
  final List<TherapistData> service;
  AssignedTherapistListLoaded(this.service);
}

class AssignedTherapistListError extends AssignedTherapistListState {
  final String message;
  AssignedTherapistListError(this.message);
}
