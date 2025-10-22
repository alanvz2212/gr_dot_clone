class OtpVerificationRequest {
  final int customerId;
  final String otp;

  OtpVerificationRequest({
    required this.customerId,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'PatientId': customerId,
      'Otp': otp,
    };
  }
}

class OtpVerificationResponse {
  final bool success;
  final String message;
  final CustomerData? customer;

  OtpVerificationResponse({
    required this.success,
    required this.message,
    this.customer,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'OTP verification completed',
      customer: json['customer'] != null 
          ? CustomerData.fromJson(json['customer'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CustomerData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? token;

  CustomerData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.token,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}