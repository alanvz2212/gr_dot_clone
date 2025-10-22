import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/service_model.dart';
import '../../../const/string_constants.dart';

class ServiceApi {
  Future<ServiceResponse> getServiceList() async {
    try {
      final url =
          '${StringConstant.baseUrl}${StringConstant.serviceListEndpoint}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ServiceResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }
}
