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

    // Initialize app version immediately
    final version = widget.currentVersion.isNotEmpty ? widget.currentVersion : "prod";

    // Initialize AuthService and check authentication status
    _authFuture = _initializeAuth();
  }

  // Move state initialization to after first frame is rendered
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This ensures the state update happens after the build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAppVersion();
    });
  }

  // Safe method to initialize app version
  void _initializeAppVersion() {
    try {
      final sharedState = Provider.of<SharedState>(context, listen: false);
      final authState = Provider.of<AuthState>(context, listen: false);

      // Set version with appropriate format
      final version = widget.currentVersion.isNotEmpty ? widget.currentVersion : "prod";
      sharedState.version = version;
      authState.setAppVersion(version); // Also store in AuthState
      log('App version set to: $version');
    } catch (e) {
      debugPrint('Error setting version: $e');
      const defaultVersion = "prod";
      try {
        final sharedState = Provider.of<SharedState>(context, listen: false);
        final authState = Provider.of<AuthState>(context, listen: false);

        sharedState.version = defaultVersion;
        authState.setAppVersion(defaultVersion);
      } catch (e) {
        debugPrint('Critical error setting default version: $e');
      }
    }
  }

  Future<bool> _initializeAuth() async {
    try {
      log('Initializing authentication...');
      // Get the AuthState safely, outside of build method
      late final AuthState authState;
      try {
        authState = Provider.of<AuthState>(context, listen: false);
      } catch (e) {
        // If we can't get it now (widget might not be mounted), initialize directly
        log('Could not access AuthState via Provider, using direct initialization');
        return await _authService.init();
      }

      // Use AuthState for initialization to centralize auth logic
      final isAuthenticated = await authState.initialize();

      if (isAuthenticated) {
        log('User is authenticated');
        return true;
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

        final isAuthenticated = snapshot.data == true;

        // Access AuthState only when needed and outside of build process
        late final AuthState authState;
        try {
          authState = Provider.of<AuthState>(context, listen: false);
        } catch (e) {
          log('Error accessing AuthState: $e');
          return const LoginScreen();
        }

        if (isAuthenticated && authState.authProfile != null) {
          // Authenticated - Navigate to ProfileChooseScreen
          log('User authenticated, navigating to ProfileChooseScreen');
          log('Current profile data: ${authState.authProfile?.name ?? "Not set"}');
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
