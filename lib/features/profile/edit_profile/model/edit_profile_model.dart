class EditProfileModelRespose {
  final bool success;
  final String message;
  final List<User> userList;

  EditProfileModelRespose({
    required this.success,
    required this.message,
    required this.userList,
  });

  factory EditProfileModelRespose.fromJson(Map<String, dynamic> json) {
    return EditProfileModelRespose(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userList:
          (json['userlist'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'userlist': userList.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int? patientId;
  final String? firstName;
  final String? lastName;
  final String? countryCode;
  final String? phone;
  final String? email;
  final int? gender;
  final String? password;

  User({
    this.patientId,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phone,
    this.email,
    this.gender,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      patientId: json['patientId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      countryCode: json['countryCode'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'firstName': firstName,
      'lastName': lastName,
      'countryCode': countryCode,
      'phone': phone,
      'email': email,
      'gender': gender,
      'password': password,
    };
  }
}
