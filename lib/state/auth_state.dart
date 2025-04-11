import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poimen/services/auth_service.dart';
import '../models/auth0_user.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class AuthState extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Auth0User? _authProfile;
  Profile? _userProfile;
  bool _isLoading = false;
  String _appVersion = '';
  String? _accessToken;
  String? _authId;
  String? _errorMessage;

  // Getters
  Auth0User? get authProfile => _authProfile;
  Profile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String get appVersion => _appVersion;
  String? get errorMessage => _errorMessage;
  String? get accessToken => _accessToken;
  String? get authId => _authId;
  bool get isAuthenticated => _accessToken != null && _authId != null && _authProfile != null;

  // Get user's full name from profile or auth data
  String getFullName() {
    // First try to get name from user profile (which has firstName and lastName)
    if (_userProfile != null) {
      return '${_userProfile!.firstName} ${_userProfile!.lastName}'.trim();
    }

    // Fallback to auth profile name
    if (_authProfile != null && _authProfile!.name.isNotEmpty) {
      return _authProfile!.name;
    }

    // Last resort
    return 'User';
  }

  // Get user's profile picture URL
  String getPictureUrl() {
    // First try to get picture from user profile
    if (_userProfile != null && _userProfile!.pictureUrl.isNotEmpty) {
      return _userProfile!.pictureUrl;
    }

    // Fallback to auth profile picture
    if (_authProfile != null && _authProfile!.picture.isNotEmpty) {
      return _authProfile!.picture;
    }

    // Return empty string if no picture available
    return '';
  }

  // Initialize the auth state and verify credentials
  Future<bool> initialize() async {
    _isLoading = true; // Set directly without notifying
    _errorMessage = null;

    try {
      log('AuthState: Initializing authentication state');

      final bool initialized = await _authService.init();

      if (initialized) {
        // Auth service was initialized successfully
        _authProfile = _authService.profile;
        await _loadTokensFromStorage();

        if (_authProfile != null && _accessToken != null && _authId != null) {
          log('AuthState: Successfully initialized with profile: ${_authProfile?.name}');
          _setLoadingSafely(false);
          return true;
        }
      }

      log('AuthState: Initialization did not find valid credentials');
      _setLoadingSafely(false);
      return false;
    } catch (e) {
      log('AuthState: Error during initialization: $e');
      _errorMessage = 'Authentication error: $e';
      _setLoadingSafely(false);
      return false;
    }
  }

  // Load tokens from secure storage
  Future<void> _loadTokensFromStorage() async {
    try {
      final results = await Future.wait([
        _secureStorage.read(key: 'accessToken'),
        _secureStorage.read(key: 'authId'),
      ]);

      _accessToken = results[0];
      _authId = results[1];

      log('AuthState: Loaded tokens - Token exists: ${_accessToken != null}, ID exists: ${_authId != null}');
    } catch (e) {
      log('AuthState: Error loading tokens: $e');
      _errorMessage = 'Failed to load authentication data';
    }
  }

  // Handle login process
  Future<bool> login() async {
    _setLoadingSafely(true);
    _errorMessage = null;

    try {
      final result = await _authService.login();

      if (result == 'Success') {
        _authProfile = _authService.profile;
        await _loadTokensFromStorage();

        log('AuthState: Login successful for user: ${_authProfile?.name}');
        _setLoadingSafely(false);
        return true;
      } else {
        log('AuthState: Login failed: $result');
        _errorMessage = result;
        _setLoadingSafely(false);
        return false;
      }
    } catch (e) {
      log('AuthState: Login error: $e');
      _errorMessage = 'Login failed: $e';
      _setLoadingSafely(false);
      return false;
    }
  }

  // Handle logout
  Future<void> logout(BuildContext context) async {
    _setLoadingSafely(true);

    try {
      await _authService.logout(context);
      clearAuthData();

      log('AuthState: Logout completed successfully');
    } catch (e) {
      log('AuthState: Logout error: $e');
      _errorMessage = 'Logout failed: $e';
    } finally {
      _setLoadingSafely(false);
    }
  }

  // Method to update user profile
  void setUserProfile(Profile profile) {
    log('AuthState: Setting user profile for ${profile.firstName} ${profile.lastName}');
    _userProfile = profile;
    _notifyListenersSafely();
  }

  // Method to clear profile data on logout
  void clearProfileData() {
    log('AuthState: Clearing profile data');
    _userProfile = null;
    _notifyListenersSafely();
  }

  // Method to clear all auth data
  void clearAuthData() {
    _authProfile = null;
    _userProfile = null;
    _accessToken = null;
    _authId = null;
    _notifyListenersSafely();
  }

  // Set app version
  void setAppVersion(String version) {
    _appVersion = version;
    _notifyListenersSafely();
  }

  // Helper method to set loading state and notify listeners safely
  void _setLoadingSafely(bool isLoading) {
    _isLoading = isLoading;
    _notifyListenersSafely();
  }

  // Safely notify listeners to prevent build-phase errors
  void _notifyListenersSafely() {
    // Only notify if we're not in the middle of a build phase
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.persistentCallbacks) {
      notifyListeners();
    } else {
      // Schedule the notification for after the build is complete
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
