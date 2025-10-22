import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clone_green_dot/features/booking_folder/id_pass/service_list/model/service_list_model.dart';
import 'package:clone_green_dot/const/string_constants.dart';

class ServiceListService {
  Future<ServiceListResponse> getServiceList() async {
    try {
      final url =
          '${StringConstant.baseUrl}${StringConstant.getPatientListEndpoint}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ServiceListResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load employee schedule: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching service list: $e');
    }
  }
}
