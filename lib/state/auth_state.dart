import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:poimen/services/auth_service.dart';
import '../models/auth0_user.dart';

class AuthState extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;

  Auth0User? _authProfile;
  bool _isLoading = false;

  Auth0User? get authProfile => _authProfile;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    
    final initialized = await _authService.init();
    if (initialized && _authService.profile != null) {
      _authProfile = _authService.profile;
    }
   
    _isLoading = false;
    notifyListeners();
    
   
  }
}
