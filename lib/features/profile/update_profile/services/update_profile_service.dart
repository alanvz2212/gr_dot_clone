import 'dart:convert';
import 'dart:io';
import 'package:clone_green_dot/features/profile/update_profile/model/update_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../../../const/string_constants.dart';

class UpdateProfileService {
  static final logger = Logger();
  static const String _baseUrl = StringConstant.baseUrl;
  static const String _endpoint = StringConstant.customerRegistrationEndpoint;
  static const String _bearerToken = token;

  Future<UpdateProfileModelResponse> updateProfile(
    UpdateProfileModelRequest request,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl$_endpoint');

      logger.i('Making API call to: $url');
      logger.i('Request body: ${jsonEncode(request.toJson())}');

      final client = http.Client();

      try {
        final response = await client
            .post(
              url,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_bearerToken',
                'Accept': 'application/json',
                'User-Agent': 'GreenDot-Flutter-App/1.0',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods':
                    'GET, POST, PUT, DELETE, OPTIONS',
                'Access-Control-Allow-Headers':
                    'Origin, Content-Type, Accept, Authorization, X-Requested-With',
              },
              body: jsonEncode(request.toJson()),
            )
            .timeout(
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
          final jsonResponse = jsonDecode(response.body);

          if (jsonResponse is Map<String, dynamic>) {
            final success = jsonResponse['success'] ?? false;
            final message = jsonResponse['message'] ?? '';

            if (!success && message.isNotEmpty) {
              if (message.toLowerCase().contains('duplicate') ||
                  message.toLowerCase().contains('already exists') ||
                  message.toLowerCase().contains('unique constraint')) {
                throw Exception(
                  'This email or mobile number is already registered. Please use a different one or try logging in.',
                );
              } else if (message.toLowerCase().contains('validation')) {
                throw Exception(
                  'Please check your input data. Some fields may not meet the required format.',
                );
              } else if (message.toLowerCase().contains('entity changes')) {
                throw Exception(
                  'Registration failed due to data validation. Please verify all fields are correctly filled.',
                );
              } else {
                throw Exception(message);
              }
            }
          }

          return UpdateProfileModelResponse.fromJson(jsonResponse);
        } else {
          String errorMessage =
              'Failed to register customer: ${response.statusCode}';
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
          throw Exception(errorMessage);
        }
      } finally {
        client.close();
      }
    } on SocketException catch (e) {
      logger.e('SocketException: $e');
      throw Exception(
        'Network connection failed. Please check your internet connection and try again.',
      );
    } on TlsException catch (e) {
      logger.e('TlsException: $e');
      throw Exception(
        'SSL/TLS connection failed. Please check your network settings.',
      );
    } on HttpException catch (e) {
      logger.e('HttpException: $e');
      throw Exception('HTTP request failed: ${e.message}');
    } catch (e) {
      logger.e('Exception occurred: $e');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }
}
