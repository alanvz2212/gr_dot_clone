class AssignedTherapistListResponse {
  final bool success;
  final String message;
  final List<TherapistData> data;

  AssignedTherapistListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssignedTherapistListResponse.fromJson(Map<String, dynamic> json) {
    return AssignedTherapistListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => TherapistData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class TherapistData {
  final int id;
  final String employeeName;

  TherapistData({required this.id, required this.employeeName});

  factory TherapistData.fromJson(Map<String, dynamic> json) {
    return TherapistData(
      id: json['id'] ?? 0,
      employeeName: json['employeeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'employeeName': employeeName};
  }
}
