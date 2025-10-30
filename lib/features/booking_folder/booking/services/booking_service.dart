import 'dart:convert';
import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/features/booking_folder/booking/model/booking_model.dart';
import 'package:http/http.dart' as http;

class BookingService {
  static Future<BookingResponse> submitBooking(BookingRequest request) async {
    try {
      final url = Uri.parse(
        '${StringConstant.baseUrl}${StringConstant.bookingEndpoint}',
      );

      final requestBody = jsonEncode(request.toJson());
      print('=== BOOKING REQUEST ===');
      print('URL: $url');
      print('Request Body: $requestBody');

      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      print('=== BOOKING RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final bookingResponse = BookingResponse.fromJson(responseData);

        if (!bookingResponse.success) {
          print('=== BOOKING ERROR DETAILS ===');
          print('Message: ${bookingResponse.message}');
          print('Booking: ${bookingResponse.booking}');
          print('Additional Data: ${bookingResponse.additionalData}');
        }

        return bookingResponse;
      } else {
        return BookingResponse(
          success: false,
          message:
              'Failed to submit booking. Status code: ${response.statusCode}. Response: ${response.body}',
        );
      }
    } catch (e) {
      print('=== BOOKING ERROR ===');
      print('Error: $e');
      return BookingResponse(
        success: false,
        message: 'Error submitting booking: $e',
      );
    }
  }
}
