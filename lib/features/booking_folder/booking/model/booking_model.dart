class BookingRequest {
  final int patientId;
  final String bookingDate;
  final String bookingTime;
  final String bookingEndTime;
  final int assignedTherapistId;
  final int? requestEmployeeId;
  final List<Service> services;

  BookingRequest({
    required this.patientId,
    required this.bookingDate,
    required this.bookingTime,
    required this.bookingEndTime,
    required this.assignedTherapistId,
    this.requestEmployeeId,
    required this.services,
  });
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'bookingEndTime': bookingEndTime,
      'assignedTherapistId': assignedTherapistId,
      'requestEmployeeId': requestEmployeeId,
      'services': services.map((s) => s.toJson()).toList(),
    };
  }
}

class Service {
  final int serviceId;
  final String name;
  final double price;
  final int quantity;
  final int assignedEmployeeId;
  final String? assistantEmployeeId;
  final String bookingTime;

  Service({
    required this.serviceId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.assignedEmployeeId,
    this.assistantEmployeeId,
    required this.bookingTime,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['serviceId'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      assignedEmployeeId: json['assignedEmployeeId'],
      assistantEmployeeId: json['assistantEmployeeId']?.toString(),
      bookingTime: json['bookingTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'assignedEmployeeId': assignedEmployeeId,
      'assistantEmployeeId': assistantEmployeeId,
      'bookingTime': bookingTime,
    };
  }
}

class BookingResponse {
  final bool success;
  final String message;
  final dynamic data;
  final dynamic additionalData;
  BookingResponse({
    required this.success,
    required this.message,
    this.data,
    this.additionalData,
  });
  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      additionalData: json['additionalData'],
    );
  }
}
