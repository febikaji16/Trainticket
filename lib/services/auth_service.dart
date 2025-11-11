import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  static const String _userKey = 'user_data';
  User? _currentUser;
  bool get isLoggedIn => _currentUser != null;
  User? get currentUser => _currentUser;

  final SharedPreferences _prefs;

  AuthService(this._prefs) {
    _loadUser();
  }

  void _loadUser() {
    final userData = _prefs.getString(_userKey);
    if (userData != null) {
      try {
        _currentUser = User.fromJson(jsonDecode(userData));
        notifyListeners();
      } catch (e) {
        debugPrint('Error loading user data: $e');
      }
    }
  }

  Future<void> saveUser(User user) async {
    _currentUser = user;
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    await _prefs.remove(_userKey);
    notifyListeners();
  }

  Future<User?> register({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    String? address,
  }) async {
    // TODO: Implement actual registration with backend
    // For now, create a mock user
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      createdAt: DateTime.now(),
    );
    
    await saveUser(user);
    return user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    // TODO: Implement actual login with backend
    // For now, create a mock user
    final user = User(
      id: '123',
      email: email,
      name: 'Test User',
      createdAt: DateTime.now(),
    );
    
    await saveUser(user);
    return user;
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    if (_currentUser == null) return;

    final updatedUser = _currentUser!.copyWith(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
    );

    await saveUser(updatedUser);
  }
}