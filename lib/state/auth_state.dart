import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:poimen/services/auth_service.dart';
import '../models/auth0_user.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class AuthState extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;

  Auth0User? _authProfile;
  Profile? _userProfile;
  bool _isLoading = false;

  Auth0User? get authProfile => _authProfile;
  Profile? get userProfile => _userProfile;
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

  // Method to update user profile
  void setUserProfile(Profile profile) {
    log('AuthState: Setting user profile for ${profile.firstName} ${profile.lastName}');
    _userProfile = profile;
    notifyListeners();
  }

  // Method to clear all data on logout
  void clearProfileData() {
    log('AuthState: Clearing user profile data');
    _userProfile = null;
    _authProfile = null;
    notifyListeners();
  }

  // Helper method to get the full name from available data
  String getFullName() {
    // First try user profile
    if (_userProfile != null) {
      return "${_userProfile!.firstName} ${_userProfile!.lastName}";
    }
    // Fall back to auth profile
    else if (_authProfile != null) {
      return _authProfile!.name;
    }
    // Last resort
    return "User";
  }

  // Helper to get picture URL
  String getPictureUrl() {
    if (_userProfile != null && _userProfile!.pictureUrl.isNotEmpty) {
      return _userProfile!.pictureUrl;
    } else if (_authProfile != null && _authProfile!.picture.isNotEmpty) {
      return _authProfile!.picture;
    }
    return "";
  }
}
