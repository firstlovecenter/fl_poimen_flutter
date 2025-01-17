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

  late Future<bool> _authFuture;

  @override
  void initState() {
    super.initState();
    // Initialize AuthService and check authentication status
    _authFuture = _initializeAuth();
  }

  Future<bool> _initializeAuth() async {
    try {
      final isInitialized = await _authService.init();

      if (isInitialized) {
        // Check if the stored values are valid
        final String? accessToken = await _authService.secureStorage.read(key: 'accessToken');
        final String? authId = await _authService.secureStorage.read(key: 'authId');
        // If credentials exist and are valid, consider user authenticated
        // js.context.callMethod('loadScript', ['redirect.js']);

        return accessToken != null && authId != null;
      }

      return false;
    } catch (e) {
      debugPrint('Error initializing auth: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SharedState>();
    state.version = widget.currentVersion;

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
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong. Please try again later.'),
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
