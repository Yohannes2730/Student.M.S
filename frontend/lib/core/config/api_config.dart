class ApiConfig {
  static const String baseUrl = 'http://localhost:3000'; // Updated to local backend
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}