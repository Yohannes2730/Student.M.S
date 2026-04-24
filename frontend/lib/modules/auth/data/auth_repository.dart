import '../../../core/storage/token_storage.dart';
import 'auth_api.dart';
import '../model/user_model.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();
  final TokenStorage _tokenStorage = TokenStorage();

  Future<User> login(String email, String password) async {
    final user = await _authApi.login(email, password);
    // In a real app, you'd get the token from the response
    await _tokenStorage.saveToken('dummy_token_${user.id}');
    return user;
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
    final user = await _authApi.register(
      name: name,
      username: username,
      email: email,
      password: password,
      role: role,
      studentId: studentId,
      phone: phone,
    );
    await _tokenStorage.saveToken('dummy_token_${user.id}');
    return user;
  }

  Future<void> logout() async {
    await _authApi.logout();
    await _tokenStorage.deleteToken();
  }

  Future<String?> getToken() async {
    return await _tokenStorage.getToken();
  }

  Future<User?> getCurrentUser() async {
    try {
      return await _authApi.getCurrentUser();
    } catch (e) {
      return null;
    }
  }
}