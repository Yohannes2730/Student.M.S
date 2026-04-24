import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../model/user_model.dart';

class AuthApi {
  final ApiClient _apiClient = ApiClient();

  Future<User> login(String email, String password) async {
    final response = await _apiClient.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return User.fromJson(response.data['user']);
  }

  Future<User> register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String role,
    String? studentId,
    String? phone,
  }) async {
    final response = await _apiClient.post('/auth/register', data: {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
      'studentId': studentId,
      'phone': phone,
    });
    return User.fromJson(response.data['user']);
  }

  Future<void> logout() async {
    await _apiClient.post('/auth/logout');
  }

  Future<User> getCurrentUser() async {
    final response = await _apiClient.get('/auth/me');
    return User.fromJson(response.data['user']);
  }
}