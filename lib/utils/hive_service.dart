import 'package:hive_flutter/hive_flutter.dart';
import '../features/auth/login/model/login_models.dart';

class HiveService {
  static const String _userBoxName = 'user_data';
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _registrationIdKey = 'registration_id';

  static Box? _userBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(_userBoxName);
  }

  static Future<void> saveUserData(UserData userData) async {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    await _userBox!.put(_userKey, userData.toJson());
    await _userBox!.put(_isLoggedInKey, true);
  }

  static UserData? getUserData() {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    final userData = _userBox!.get(_userKey);
    if (userData != null) {
      return UserData.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  static bool isLoggedIn() {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    return _userBox!.get(_isLoggedInKey, defaultValue: false);
  }

  static Future<void> clearUserData() async {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    await _userBox!.delete(_userKey);
    await _userBox!.put(_isLoggedInKey, false);
    await _userBox!.delete(_registrationIdKey);
  }

  static Future<void> saveRegistrationId(int registrationId) async {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    await _userBox!.put(_registrationIdKey, registrationId);
  }

  static int? getRegistrationId() {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    return _userBox!.get(_registrationIdKey);
  }

  static Future<void> clearRegistrationId() async {
    if (_userBox == null) {
      throw Exception('Hive not initialized. Call HiveService.init() first.');
    }

    await _userBox!.delete(_registrationIdKey);
  }

  static int? getUserId() {
    final userData = getUserData();
    return userData?.id;
  }

  static String? getUserName() {
    final userData = getUserData();
    return userData?.name;
  }

  static String? getUserEmail() {
    final userData = getUserData();
    return userData?.email;
  }

  static String? getUserPhone() {
    final userData = getUserData();
    return userData?.phone;
  }

  static Future<void> close() async {
    await _userBox?.close();
  }
}
