import 'dart:convert';
import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/features/profile/update_profile/model/update_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class UpdateProfileService {
  static final logger = Logger();

  static Future<UpdateProfileModelResponse> updateProfile(
    UpdateProfileModelRequest request,
  ) async {
    try {
      final url = Uri.parse(
        '${StringConstant.baseUrl}${StringConstant.updateProfileEndpoint}',
      );

      logger.i('Making API call to: $url');
      logger.i('Request body: ${jsonEncode(request.toJson())}');

      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception(
            'Request timeout. Please check your internet connection and try again.',
          );
        },
      );

      logger.i('Response status code: ${response.statusCode}');
      logger.i('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        if (responseData is Map<String, dynamic>) {
          final success = responseData['success'] ?? false;
          final message = responseData['message'] ?? '';

          if (!success && message.isNotEmpty) {
            logger.w('API returned success: false with message: $message');
            throw Exception(message);
          }
        }

        logger.i('Update Profile successful');
        return UpdateProfileModelResponse.fromJson(responseData);
      } else {
        String errorMessage =
            'Failed to submit Update Profile. Status code: ${response.statusCode}';
        try {
          final errorResponse = jsonDecode(response.body);
          if (errorResponse is Map<String, dynamic>) {
            if (errorResponse.containsKey('message')) {
              errorMessage = errorResponse['message'];
            } else if (errorResponse.containsKey('error')) {
              errorMessage = errorResponse['error'];
            } else if (errorResponse.containsKey('errors')) {
              errorMessage = errorResponse['errors'].toString();
            } else {
              errorMessage = 'Server error: ${response.body}';
            }
          }
        } catch (parseError) {
          errorMessage = 'Server error: ${response.body}';
        }
        logger.e('Update Profile failed: $errorMessage');
        return UpdateProfileModelResponse(
          success: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      logger.e('Update Profile Service Error: $e');
      return UpdateProfileModelResponse(
        success: false,
        message: 'Error submitting Update Profile: $e',
      );
    }
  }
}
