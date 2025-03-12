import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/state/auth_state.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class HandleLogin extends StatefulWidget {
  const HandleLogin({super.key, required this.currentVersion});

  final String currentVersion;

  @override
  State<HandleLogin> createState() => _HandleLoginState();
}

class _HandleLoginState extends State<HandleLogin> {
  final AuthService _authService = AuthService.instance;
  bool _isRetrying = false;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  late Future<bool> _authFuture;

  @override
  void initState() {
    super.initState();
    log('HandleLogin initialized');
    // Initialize AuthService and check authentication status
    _authFuture = _initializeAuth();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use Future.microtask to move the state update outside the build phase
    Future.microtask(() {
      final sharedState = Provider.of<SharedState>(context, listen: false);
      // Also initialize the AuthState
      final authState = Provider.of<AuthState>(context, listen: false);
      authState.init(); // Initialize the auth state

      // Check if widget.currentVersion is a valid version string
      // If it's not valid, use "prod" as a fallback
      try {
        // Set version with appropriate format
        sharedState.version = widget.currentVersion.isNotEmpty ? widget.currentVersion : "prod";
        log('App version set to: ${sharedState.version}');
      } catch (e) {
        debugPrint('Error setting version: $e');
        sharedState.version = "prod";
      }
    });
  }

  Future<bool> _initializeAuth() async {
    try {
      log('Initializing authentication...');
      final isInitialized = await _authService.init();

      if (isInitialized) {
        // Check if the stored values are valid
        final String? accessToken = await _authService.secureStorage.read(key: 'accessToken');
        final String? authId = await _authService.secureStorage.read(key: 'authId');

        log('Access Token: ${accessToken != null ? 'exists' : 'null'}');
        log('Auth ID: ${authId != null ? 'exists' : 'null'}');
        log('User profile: ${_authService.profile != null ? _authService.profile!.name : 'null'}');

        // If user profile is still null but we have tokens, attempt to initialize again
        if (_authService.profile == null && accessToken != null && authId != null) {
          log('Profile not loaded but credentials exist - attempting to reload');
          await _authService.init();
          log('After second init attempt - Profile: ${_authService.profile != null ? 'loaded' : 'still null'}');
        }

        // If credentials exist and are valid, consider user authenticated
        return accessToken != null && authId != null;
      }

      log('Auth initialization failed or user not logged in');
      return false;
    } catch (e) {
      log('Error initializing auth: $e');

      // Implement retry logic
      if (_retryCount < _maxRetries && !_isRetrying) {
        _isRetrying = true;
        _retryCount++;
        log('Retrying authentication initialization (attempt $_retryCount of $_maxRetries)');
        await Future.delayed(const Duration(seconds: 2)); // Wait before retry
        _isRetrying = false;
        return _initializeAuth();
      }

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          log('Auth FutureBuilder error: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Authentication error. Please try again.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _retryCount = 0;
                        _authFuture = _initializeAuth();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          // Authenticated - Navigate to HomeScreen
          log('User authenticated, navigating to ProfileChooseScreen');
          log('Current profile data: ${_authService.profile?.name ?? "Not set"}');
          return const ProfileChooseScreen();
        } else {
          // Not authenticated - Navigate to LoginScreen
          log('User not authenticated, navigating to LoginScreen');
          return const LoginScreen();
        }
      },
    );
  }
}
