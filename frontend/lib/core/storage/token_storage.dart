import 'package:hive/hive.dart';

class TokenStorage {
  static const String _boxName = 'authBox';
  static const String _tokenKey = 'token';

  Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_tokenKey);
  }

  Future<void> deleteToken() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_tokenKey);
  }
}