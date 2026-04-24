import 'attendance_api.dart';
import '../model/attendance_model.dart';

class AttendanceRepository {
  final AttendanceApi _attendanceApi = AttendanceApi();

  Future<List<Attendance>> getAttendance(String studentId) async {
    return await _attendanceApi.getAttendance(studentId);
  }

  Future<void> markAttendance(String studentId, bool present) async {
    await _attendanceApi.markAttendance(studentId, present);
  }
}