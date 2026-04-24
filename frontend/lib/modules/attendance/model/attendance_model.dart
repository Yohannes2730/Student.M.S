class Attendance {
  final String id;
  final String studentId;
  final DateTime date;
  final bool present;

  Attendance({
    required this.id,
    required this.studentId,
    required this.date,
    required this.present,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      studentId: json['studentId'],
      date: DateTime.parse(json['date']),
      present: json['present'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'date': date.toIso8601String(),
      'present': present,
    };
  }
}