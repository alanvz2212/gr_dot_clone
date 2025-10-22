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

      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return BookingResponse.fromJson(responseData);
      } else {
        return BookingResponse(
          success: false,
          message:
              'Failed to submit booking. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Error submitting booking: $e',
      );
    }
  }
}
