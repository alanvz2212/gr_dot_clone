class BookingDetailsResponse {
  final bool success;
  final String message;
  final BookingData? data;

  BookingDetailsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BookingDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BookingDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BookingData {
  final Booking? booking;
  final List<BookingItem> bookingItems;

  BookingData({
    this.booking,
    required this.bookingItems,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      booking:
          json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      bookingItems: (json['bookingItems'] as List<dynamic>?)
              ?.map((e) => BookingItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking': booking?.toJson(),
      'bookingItems': bookingItems.map((e) => e.toJson()).toList(),
    };
  }
}

class Booking {
  final int id;
  final int patientId;
  final String bookingDate;
  final String bookingTime;
  final String bookingEndTime;
  final int assignedEmployeeId;
  final dynamic requestEmployeeId;

  Booking({
    required this.id,
    required this.patientId,
    required this.bookingDate,
    required this.bookingTime,
    required this.bookingEndTime,
    required this.assignedEmployeeId,
    this.requestEmployeeId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      patientId: json['patientId'] ?? 0,
      bookingDate: json['bookingDate'] ?? '',
      bookingTime: json['bookingTime'] ?? '',
      bookingEndTime: json['bookingEndTime'] ?? '',
      assignedEmployeeId: json['assignedEmployeeId'] ?? 0,
      requestEmployeeId: json['requestEmployeeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'bookingEndTime': bookingEndTime,
      'assignedEmployeeId': assignedEmployeeId,
      'requestEmployeeId': requestEmployeeId,
    };
  }
}

class BookingItem {
  final int id;
  final int serviceId;
  final double price;
  final int quantity;
  final String bookingTime;
  final int assignedEmployeeId;
  final dynamic assistantEmployeeId;

  BookingItem({
    required this.id,
    required this.serviceId,
    required this.price,
    required this.quantity,
    required this.bookingTime,
    required this.assignedEmployeeId,
    this.assistantEmployeeId,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      id: json['id'] ?? 0,
      serviceId: json['serviceId'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      bookingTime: json['bookingTime'] ?? '',
      assignedEmployeeId: json['assignedEmployeeId'] ?? 0,
      assistantEmployeeId: json['assistantEmployeeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'price': price,
      'quantity': quantity,
      'bookingTime': bookingTime,
      'assignedEmployeeId': assignedEmployeeId,
      'assistantEmployeeId': assistantEmployeeId,
    };
  }
}
