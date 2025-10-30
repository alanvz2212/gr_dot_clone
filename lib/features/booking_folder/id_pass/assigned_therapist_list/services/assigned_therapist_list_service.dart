import 'dart:convert';
import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/model/assigned_therapist_list_model.dart';
import 'package:http/http.dart' as http;

class AssignedTherapistListService {
  Future<AssignedTherapistListResponse> getAssignedTherapistList() async {
    try {
      final url =
          '${StringConstant.baseUrl}${StringConstant.assignedTherapistEndpoint}';

      print('Fetching therapist list from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return AssignedTherapistListResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load assigned therapist list: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching assigned therapist list: $e');
      throw Exception('Error fetching assigned therapist list: $e');
    }
  }
}
