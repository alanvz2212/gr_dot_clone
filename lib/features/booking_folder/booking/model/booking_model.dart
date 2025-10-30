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
    final json = <String, dynamic>{
      'PatientId': patientId,
      'BookingDate': bookingDate,
      'BookingTime': bookingTime,
      'BookingEndTime': bookingEndTime,
      'AssignedTherapistId': assignedTherapistId,
      'RequestEmployeeId': requestEmployeeId,
      'Services': services.map((s) => s.toJson()).toList(),
    };
    return json;
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
    final json = <String, dynamic>{
      'ServiceId': serviceId,
      'Name': name,
      'Price': price,
      'Quantity': quantity,
      'AssignedEmployeeId': assignedEmployeeId,
      'AssistantEmployeeId': assistantEmployeeId ?? '',
      'BookingTime': bookingTime,
    };
    return json;
  }
}

class BookingResponse {
  final bool success;
  final String message;
  final dynamic booking;
  final dynamic additionalData;
  BookingResponse({
    required this.success,
    required this.message,
    this.booking,
    this.additionalData,
  });
  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      booking: json['booking'] ?? json['data'],
      additionalData: json['additionalData'],
    );
  }
}
