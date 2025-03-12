import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/screens/login_screen.dart';
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
    // Initialize AuthService and check authentication status
    _authFuture = _initializeAuth();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use Future.microtask to move the state update outside the build phase
    Future.microtask(() {
      final sharedState = Provider.of<SharedState>(context, listen: false);

      // Check if widget.currentVersion is a valid version string
      // If it's not valid, use "prod" as a fallback
      try {
        // Set version with appropriate format
        sharedState.version = widget.currentVersion.isNotEmpty ? widget.currentVersion : "prod";
      } catch (e) {
        debugPrint('Error setting version: $e');
        sharedState.version = "prod";
      }
    });
  }

  Future<bool> _initializeAuth() async {
    try {
      final isInitialized = await _authService.init();

      if (isInitialized) {
        // Check if the stored values are valid
        final String? accessToken = await _authService.secureStorage.read(key: 'accessToken');
        final String? authId = await _authService.secureStorage.read(key: 'authId');

        debugPrint('Access Token: ${accessToken != null ? 'exists' : 'null'}');
        debugPrint('Auth ID: ${authId != null ? 'exists' : 'null'}');

        // If credentials exist and are valid, consider user authenticated
        return accessToken != null && authId != null;
      }

      return false;
    } catch (e) {
      debugPrint('Error initializing auth: $e');

      // Implement retry logic
      if (_retryCount < _maxRetries && !_isRetrying) {
        _isRetrying = true;
        _retryCount++;
        debugPrint('Retrying authentication initialization (attempt $_retryCount of $_maxRetries)');
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
          return const ProfileChooseScreen();
        } else {
          // Not authenticated - Navigate to LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
