class Student {
  final String id;
  final String username;
  final String name;
  final String email;
  final String studentId; // Student ID (required for students)
  final String classId;
  final String? phone;
  final String? parentEmail;
  final DateTime? enrollmentDate;

  Student({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.studentId,
    required this.classId,
    this.phone,
    this.parentEmail,
    this.enrollmentDate,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      studentId: json['studentId'],
      classId: json['classId'],
      phone: json['phone'],
      parentEmail: json['parentEmail'],
      enrollmentDate: json['enrollmentDate'] != null ? DateTime.parse(json['enrollmentDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'studentId': studentId,
      'classId': classId,
      'phone': phone,
      'parentEmail': parentEmail,
      'enrollmentDate': enrollmentDate?.toIso8601String(),
    };
  }
}