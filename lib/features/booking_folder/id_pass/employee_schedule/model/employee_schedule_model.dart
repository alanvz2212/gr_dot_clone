class EmployeeScheduleResponse {
  final bool success;
  final String message;
  final List<EmployeeSchedule> data;

  EmployeeScheduleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EmployeeScheduleResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeScheduleResponse(
      success: json['success'],
      message: json['message'],
      data: List<EmployeeSchedule>.from(
        json['data'].map((x) => EmployeeSchedule.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EmployeeSchedule {
  final String name;
  final String title;
  final String? code;
  final String? email;
  final String? phone;
  final String? displayName;
  final String? primaryAddress;
  final String? secondaryAddress;
  final String? image;
  final int? genderId;
  final String? gender;
  final DateTime? dateOfBirth;
  final DateTime? joiningDate;
  final DateTime? resignDate;
  final int? roleId;
  final String? role;
  final String? currentAddress;
  final String? permanentAddress;
  final String? emergencyNumber;
  final String? password;
  final String? salt;
  final String? description;
  final bool? isDailySMS;
  final bool? isDailyEmail;
  final bool? isBookingApplicable;
  final String? passwordHash;
  final String? passwordSalt;
  final List<Schedule> schedules;
  final int id;
  final String mainId;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final bool? isDeleted;
  final bool? isJson;

  EmployeeSchedule({
    required this.name,
    required this.title,
    this.code,
    this.email,
    this.phone,
    this.displayName,
    this.primaryAddress,
    this.secondaryAddress,
    this.image,
    this.genderId,
    this.gender,
    this.dateOfBirth,
    this.joiningDate,
    this.resignDate,
    this.roleId,
    this.role,
    this.currentAddress,
    this.permanentAddress,
    this.emergencyNumber,
    this.password,
    this.salt,
    this.description,
    this.isDailySMS,
    this.isDailyEmail,
    this.isBookingApplicable,
    this.passwordHash,
    this.passwordSalt,
    required this.schedules,
    required this.id,
    required this.mainId,
    this.createdDate,
    this.updatedDate,
    this.isDeleted,
    this.isJson,
  });

  factory EmployeeSchedule.fromJson(Map<String, dynamic> json) {
    return EmployeeSchedule(
      name: json['name'],
      title: json['title'],
      code: json['code'],
      email: json['email'],
      phone: json['phone'],
      displayName: json['displayName'],
      primaryAddress: json['primaryAddress'],
      secondaryAddress: json['secondaryAddress'],
      image: json['image'],
      genderId: json['genderId'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      joiningDate: json['joiningDate'] != null
          ? DateTime.parse(json['joiningDate'])
          : null,
      resignDate: json['resignDate'] != null
          ? DateTime.parse(json['resignDate'])
          : null,
      roleId: json['roleId'],
      role: json['role'],
      currentAddress: json['currentAddress'],
      permanentAddress: json['permanentAddress'],
      emergencyNumber: json['emergencyNumber'],
      password: json['password'],
      salt: json['salt'],
      description: json['description'],
      isDailySMS: json['isDailySMS'],
      isDailyEmail: json['isDailyEmail'],
      isBookingApplicable: json['isBookingApplicable'],
      passwordHash: json['passwordHash'],
      passwordSalt: json['passwordSalt'],
      schedules: List<Schedule>.from(
        json['schedules'].map((x) => Schedule.fromJson(x)),
      ),
      id: json['id'],
      mainId: json['mainId'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      updatedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'])
          : null,
      isDeleted: json['isDeleted'],
      isJson: json['isJson'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'code': code,
    'email': email,
    'phone': phone,
    'displayName': displayName,
    'primaryAddress': primaryAddress,
    'secondaryAddress': secondaryAddress,
    'image': image,
    'genderId': genderId,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'joiningDate': joiningDate?.toIso8601String(),
    'resignDate': resignDate?.toIso8601String(),
    'roleId': roleId,
    'role': role,
    'currentAddress': currentAddress,
    'permanentAddress': permanentAddress,
    'emergencyNumber': emergencyNumber,
    'password': password,
    'salt': salt,
    'description': description,
    'isDailySMS': isDailySMS,
    'isDailyEmail': isDailyEmail,
    'isBookingApplicable': isBookingApplicable,
    'passwordHash': passwordHash,
    'passwordSalt': passwordSalt,
    'schedules': List<dynamic>.from(schedules.map((x) => x.toJson())),
    'id': id,
    'mainId': mainId,
    'createdDate': createdDate?.toIso8601String(),
    'updatedDate': updatedDate?.toIso8601String(),
    'isDeleted': isDeleted,
    'isJson': isJson,
  };
}

class Schedule {
  final int employeeId;
  final int day;
  final String timeFrom;
  final DateTime timeFromDate;
  final String timeTo;
  final DateTime timeToDate;
  final int id;
  final String mainId;
  final DateTime createdDate;
  final DateTime updatedDate;
  final bool isDeleted;
  final bool isJson;

  Schedule({
    required this.employeeId,
    required this.day,
    required this.timeFrom,
    required this.timeFromDate,
    required this.timeTo,
    required this.timeToDate,
    required this.id,
    required this.mainId,
    required this.createdDate,
    required this.updatedDate,
    required this.isDeleted,
    required this.isJson,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      employeeId: json['employeeId'],
      day: json['day'],
      timeFrom: json['timeFrom'],
      timeFromDate: DateTime.parse(json['timeFromDate']),
      timeTo: json['timeTo'],
      timeToDate: DateTime.parse(json['timeToDate']),
      id: json['id'],
      mainId: json['mainId'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      isDeleted: json['isDeleted'],
      isJson: json['isJson'],
    );
  }

  Map<String, dynamic> toJson() => {
    'employeeId': employeeId,
    'day': day,
    'timeFrom': timeFrom,
    'timeFromDate': timeFromDate.toIso8601String(),
    'timeTo': timeTo,
    'timeToDate': timeToDate.toIso8601String(),
    'id': id,
    'mainId': mainId,
    'createdDate': createdDate.toIso8601String(),
    'updatedDate': updatedDate.toIso8601String(),
    'isDeleted': isDeleted,
    'isJson': isJson,
  };
}
