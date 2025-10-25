import 'dart:convert';

import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/features/booking_folder/booking_list/model/booking_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BookingListService {
  static final logger = Logger();

  Future<BookingModelResponse> postBookingList(int userId, int bookId) async {
    try {
      final url = Uri.parse(
        '${StringConstant.baseUrl}${StringConstant.editProfileEndpoint}',
      );

      final requestBody = {'patientId': userId, 'bookingId': bookId};

      logger.i('Edit Profile URL: $url');
      logger.i('Request Body: ${jsonEncode(requestBody)}');
      logger.i('User ID: $userId');
      logger.i('booking Id: $bookId');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'GreenDot-Flutter-App/1.0',
        },
        body: jsonEncode(requestBody),
      );

      logger.i('Response Status Code: ${response.statusCode}');
      logger.i('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return BookingModelResponse.fromJson(jsonData);
      } else {
        logger.e('Failed to load edit profile: ${response.statusCode}');
        logger.e('Response Error: ${response.body}');
        throw Exception('Failed to load edit profile : ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      logger.e(
        'Error fetching edit profile: $e',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Error fetching edit profile: $e');
    }
  }
}
