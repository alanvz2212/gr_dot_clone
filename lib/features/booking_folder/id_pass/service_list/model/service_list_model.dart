class ServiceListResponse {
  final bool success;
  final String message;
  final List<ServiceList> data;

  ServiceListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) {
    return ServiceListResponse(
      success: json['success'],
      message: json['message'],
      data: List<ServiceList>.from(
        json['data'].map((x) => ServiceList.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ServiceList {
  final int id;
  final String serviceName;
  final int serviceDuration;
  final int serviceTypeId;
  final String serviceType;
  final double price;
  final String? image;
  final int genderId;
  final String gender;
  final int taxId;
  final double tax;

  ServiceList({
    required this.id,
    required this.serviceName,
    required this.serviceDuration,
    required this.serviceTypeId,
    required this.serviceType,
    required this.price,
    this.image,
    required this.genderId,
    required this.gender,
    required this.taxId,
    required this.tax,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      id: json['id'],
      serviceName: json['serviceName'],
      serviceDuration: json['serviceDuration'],
      serviceTypeId: json['serviceTypeId'],
      serviceType: json['serviceType'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      genderId: json['genderId'],
      gender: json['gender'],
      taxId: json['taxId'],
      tax: (json['tax'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
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
