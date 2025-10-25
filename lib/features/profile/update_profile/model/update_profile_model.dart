class UpdateProfileModelRequest {
  final int patientId;
  final String firstName;
  final String lastName;
  final String phone;
  final String countryCode;
  final String email;
  final String password;
  final int gender;

  UpdateProfileModelRequest({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.countryCode,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': patientId,
      'FirstName': firstName,
      'LastName': lastName,
      'Mobile': phone,
      'CountryCode': countryCode,
      'Email': email,
      'Password': password,
      'Gender': gender,
    };
  }
}

class UpdateProfileModelResponse {
  final bool success;
  final String message;
  final dynamic data;
  final dynamic additionalData;

  UpdateProfileModelResponse({
    required this.success,
    required this.message,
    this.data,
    this.additionalData,
  });

  factory UpdateProfileModelResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModelResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      additionalData: json['additionalData'],
    );
  }
}

class Patient {
  final String firstName;
  final String lastName;
  final String countryCode;
  final String phone;
  final bool isWhatsApp;
  final String name;
  final int genderId;
  final String? gender;
  final String? address;
  final String email;
  final String? identification;
  final String? dateOfBirth;
  final String? referalPatientId;
  final String? referalPatient;
  final String? leaedSourceId;
  final String? leaedSource;
  final String? sourceNote;
  final String? note;
  final bool isNotificationEnabled;
  final String? secondaryPhone;
  final String? anniversary;
  final String? taxNumber;
  final String? stateId;
  final String? state;
  final String? clientCode;
  final String? referredy;
  final String? promotion;
  final String? transaction;
  final bool isCustomerReferral;
  final String password;
  final String salt;
  final String otp;
  final String otpGeneratedAt;
  final int id;
  final String mainId;
  final String createdDate;
  final String updatedDate;
  final bool isDeleted;
  final bool isJson;

  Patient({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phone,
    required this.isWhatsApp,
    required this.name,
    required this.genderId,
    this.gender,
    this.address,
    required this.email,
    this.identification,
    this.dateOfBirth,
    this.referalPatientId,
    this.referalPatient,
    this.leaedSourceId,
    this.leaedSource,
    this.sourceNote,
    this.note,
    required this.isNotificationEnabled,
    this.secondaryPhone,
    this.anniversary,
    this.taxNumber,
    this.stateId,
    this.state,
    this.clientCode,
    this.referredy,
    this.promotion,
    this.transaction,
    required this.isCustomerReferral,
    required this.password,
    required this.salt,
    required this.otp,
    required this.otpGeneratedAt,
    required this.id,
    required this.mainId,
    required this.createdDate,
    required this.updatedDate,
    required this.isDeleted,
    required this.isJson,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      countryCode: json['countryCode'] ?? '',
      phone: json['phone'] ?? '',
      isWhatsApp: json['isWhatsApp'] ?? false,
      name: json['name'] ?? '',
      genderId: json['genderId'] ?? 0,
      gender: json['gender'],
      address: json['address'],
      email: json['email'] ?? '',
      identification: json['identification'],
      dateOfBirth: json['dateOfBirth'],
      referalPatientId: json['referalPatientId'],
      referalPatient: json['referalPatient'],
      leaedSourceId: json['leaedSourceId'],
      leaedSource: json['leaedSource'],
      sourceNote: json['sourceNote'],
      note: json['note'],
      isNotificationEnabled: json['isNotificationEnabled'] ?? false,
      secondaryPhone: json['secondaryPhone'],
      anniversary: json['anniversary'],
      taxNumber: json['taxNumber'],
      stateId: json['stateId'],
      state: json['state'],
      clientCode: json['clientCode'],
      referredy: json['referredy'],
      promotion: json['promotion'],
      transaction: json['transaction'],
      isCustomerReferral: json['isCustomerReferral'] ?? false,
      password: json['password'] ?? '',
      salt: json['salt'] ?? '',
      otp: json['otp'] ?? '',
      otpGeneratedAt: json['otpGeneratedAt'] ?? '',
      id: json['id'] ?? 0,
      mainId: json['mainId'] ?? '',
      createdDate: json['createdDate'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      isJson: json['isJson'] ?? false,
    );
  }
}
