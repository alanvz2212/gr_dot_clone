import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/features/booking_folder/booking_list/model/booking_list_model.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class BookingDetailsService {
  final Dio dio = Dio();

  BookingDetailsService() {
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestData: true,
          printResponseData: true,
          printResponseMessage: true,
        ),
      ),
    );
  }

  Future<BookingDetailsResponse> postBookingDetails(
    int userId,
    int bookId,
  ) async {
    try {
      final url =
          '${StringConstant.baseUrl}${StringConstant.editProfileEndpoint}';

      final requestBody = {'patientId': userId, 'id': bookId};

      final response = await dio.post(
        url,
        data: jsonEncode(requestBody),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'User-Agent': 'GreenDot-Flutter-App/1.0',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        return BookingDetailsResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load booking details: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching booking details: $e');
    }
  }
}
