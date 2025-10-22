import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/employee_schedule_model.dart';
import '../../../../../const/string_constants.dart';

class EmployeeScheduleService {
  Future<EmployeeScheduleResponse> getEmployeeSchedule() async {
    try {
      final url =
          '${StringConstant.baseUrl}${StringConstant.getEmployeesEndpoint}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EmployeeScheduleResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load employee schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching employee schedule: $e');
    }
  }
}
