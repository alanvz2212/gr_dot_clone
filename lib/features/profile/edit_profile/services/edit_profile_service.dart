import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:clone_green_dot/features/profile/edit_profile/model/edit_profile_model.dart';
import 'package:clone_green_dot/const/string_constants.dart';
import 'package:clone_green_dot/utils/hive_service.dart';

class EditProfileService {
  static final logger = Logger();

  Future<EditProfileModelRespose> posteditProfile(int userId) async {
    try {
      final url = Uri.parse(
        '${StringConstant.baseUrl}${StringConstant.editProfileEndpoint}',
      );

      final requestBody = {'id': userId};

      logger.i('Edit Profile URL: $url');
      logger.i('Request Body: ${jsonEncode(requestBody)}');
      logger.i('User ID: $userId');

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
        return EditProfileModelRespose.fromJson(jsonData);
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
