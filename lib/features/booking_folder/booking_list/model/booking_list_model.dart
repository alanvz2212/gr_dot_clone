class BookingModelResponse {
  final bool success;
  final String message;
  final BookingData? data;

  BookingModelResponse({required this.success, required this.message, this.data});

  factory BookingModelResponse.fromJson(Map<String, dynamic> json) {
    return BookingModelResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class BookingData {
  final Booking? booking;
  final List<BookingItem>? bookingItems;

  BookingData({this.booking, this.bookingItems});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      booking: json['booking'] != null
          ? Booking.fromJson(json['booking'])
          : null,
      bookingItems: json['bookingItems'] != null
          ? List<BookingItem>.from(
              json['bookingItems'].map((x) => BookingItem.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking': booking?.toJson(),
      'bookingItems': bookingItems?.map((x) => x.toJson()).toList(),
    };
  }
}

class Booking {
  final int? id;
  final int? patientId;
  final String? bookingDate;
  final String? bookingTime;
  final String? bookingEndTime;
  final int? assignedEmployeeId;
  final int? requestEmployeeId;

  Booking({
    this.id,
    this.patientId,
    this.bookingDate,
    this.bookingTime,
    this.bookingEndTime,
    this.assignedEmployeeId,
    this.requestEmployeeId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      patientId: json['patientId'],
      bookingDate: json['bookingDate'],
      bookingTime: json['bookingTime'],
      bookingEndTime: json['bookingEndTime'],
      assignedEmployeeId: json['assignedEmployeeId'],
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
  final int? id;
  final int? serviceId;
  final double? price;
  final int? quantity;
  final String? bookingTime;
  final int? assignedEmployeeId;
  final String? assistantEmployeeId;

  BookingItem({
    this.id,
    this.serviceId,
    this.price,
    this.quantity,
    this.bookingTime,
    this.assignedEmployeeId,
    this.assistantEmployeeId,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      id: json['id'],
      serviceId: json['serviceId'],
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'],
      bookingTime: json['bookingTime'],
      assignedEmployeeId: json['assignedEmployeeId'],
      assistantEmployeeId: json['assistantEmployeeId']?.toString(),
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
