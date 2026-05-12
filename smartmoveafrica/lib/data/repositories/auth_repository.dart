import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> login(String email, String password);
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
  Future<void> logout();
}

class MockAuthRepository implements AuthRepository {
  static const _tokenKey = 'session_token';
  static const _nameKey = 'user_name';
  static const _emailKey = 'user_email';
  static const _phoneKey = 'user_phone';
  final FlutterSecureStorage _secureStorage;

  MockAuthRepository(this._secureStorage);

  @override
  Future<AppUser?> getCurrentUser() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) return null;
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey);
    if (email == null) return null;
    return AppUser(
      id: 'local-user',
      name: prefs.getString(_nameKey) ?? 'SmartMove User',
      email: email,
      phone: prefs.getString(_phoneKey) ?? '+254700000000',
    );
  }

  @override
  Future<AppUser> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final user = AppUser(
      id: 'local-user',
      name: 'SmartMove User',
      email: email,
      phone: '+254700000000',
    );
    await _persistSession(user);
    return user;
  }

  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final user = AppUser(id: 'local-user', name: name, email: email, phone: phone);
    await _persistSession(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: _tokenKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
  }

  Future<void> _persistSession(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await _secureStorage.write(key: _tokenKey, value: 'mock-session-token');
    await prefs.setBool('is_logged_in', true);
    await prefs.setString(_nameKey, user.name);
    await prefs.setString(_emailKey, user.email);
    await prefs.setString(_phoneKey, user.phone);
  }
}
