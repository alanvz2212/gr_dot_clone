import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/otp_models.dart';
import 'package:logger/logger.dart';
import '../../../const/string_constants.dart';

class OtpService {
  static final logger = Logger();

  static const String _baseUrl = StringConstant.baseUrl;
  static const String _endpoint = StringConstant.verifyEndpoint;
  static const String _bearerToken = token;

  Future<OtpVerificationResponse> verifyOtp(
    OtpVerificationRequest request,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl$_endpoint');

      logger.i('Making OTP verification API call to: $url');
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

        logger.i('OTP Response status code: ${response.statusCode}');
        logger.i('OTP Response body: ${response.body}');

        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          final success = jsonResponse['success'] ?? false;
          final message = jsonResponse['message'] ?? '';

          if (success) {
            return OtpVerificationResponse.fromJson(jsonResponse);
          } else {
            throw Exception(
              message.isNotEmpty ? message : 'OTP verification failed',
            );
          }
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          return OtpVerificationResponse.fromJson(jsonResponse);
        } else {
          throw Exception('Failed to verify OTP: ${response.statusCode}');
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
      logger.e('OTP Service Error: $e');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }
}
