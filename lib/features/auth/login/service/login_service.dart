import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../model/login_models.dart';
import '../../../../const/string_constants.dart';

class LoginService {
  static final logger = Logger();
  static Future<LoginResponse> login(LoginRequest request) async {
    try {
      final url = Uri.parse(
        '${StringConstant.baseUrl}${StringConstant.loginEndpoint}',
      );
      logger.i('Login URL: $url');
      logger.i('Request Body: ${jsonEncode(request.toJson())}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'GreenDot-Flutter-App/1.0',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
        },
        body: jsonEncode(request.toJson()),
      );
      logger.i('Response Status Code: ${response.statusCode}');
      logger.i('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        logger.e('Login failed with status: ${response.statusCode}');
        return LoginResponse(
          success: false,
          message: 'Login failed. Please try again.',
        );
      }
    } catch (e,stackTrace) {
      logger.e('Network error occurred: $e', error: e, stackTrace: stackTrace);
      return LoginResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }
}
