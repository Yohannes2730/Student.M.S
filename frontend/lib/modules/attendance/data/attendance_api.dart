import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../model/attendance_model.dart';

class AttendanceApi {
  final ApiClient _apiClient = ApiClient();

  Future<List<Attendance>> getAttendance(String studentId) async {
    final response = await _apiClient.get('/attendance', queryParameters: {'studentId': studentId});
    return (response.data as List).map((e) => Attendance.fromJson(e)).toList();
  }

  Future<void> markAttendance(String studentId, bool present) async {
    await _apiClient.post('/attendance/mark', data: {
      'studentId': studentId,
      'present': present,
    });
  }
}