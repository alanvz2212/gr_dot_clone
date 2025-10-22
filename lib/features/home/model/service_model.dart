class ServiceResponse {
  final bool success;
  final String message;
  final List<ServiceData> data;

  ServiceResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ServiceData.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class ServiceData {
  final int id;
  final String serviceName;
  final int? serviceDuration;
  final int serviceTypeId;
  final String serviceType;
  final double price;
  final String? image;
  final int genderId;
  final String gender;
  final int taxId;
  final int tax;

  ServiceData({
    required this.id,
    required this.serviceName,
    this.serviceDuration,
    required this.serviceTypeId,
    required this.serviceType,
    required this.price,
    this.image,
    required this.genderId,
    required this.gender,
    required this.taxId,
    required this.tax,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      serviceDuration: json['serviceDuration'],
      serviceTypeId: json['serviceTypeId'] ?? 0,
      serviceType: json['serviceType'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
      genderId: json['genderId'] ?? 0,
      gender: json['gender'] ?? '',
      taxId: json['taxId'] ?? 0,
      tax: json['tax'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'serviceDuration': serviceDuration,
      'serviceTypeId': serviceTypeId,
      'serviceType': serviceType,
      'price': price,
      'image': image,
      'genderId': genderId,
      'gender': gender,
      'taxId': taxId,
      'tax': tax,
    };
  }
}
