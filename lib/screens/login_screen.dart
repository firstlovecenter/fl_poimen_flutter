import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/state/auth_state.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/auth_button.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? Colors.white : Colors.black;

    // Use the AuthState for all auth-related functionality
    final authState = context.watch<AuthState>();

    // Keep SharedState for backward compatibility
    final sharedState = context.watch<SharedState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (authState.isLoading)
              const LoadingScreen()
            else
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                      child: RiveAnimation.asset('assets/animations/spinning_logo.riv'),
                    ),
                    const Padding(padding: EdgeInsets.all(16.0)),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                              text: 'Welcome to the',
                              style: TextStyle(
                                color: textColor,
                              )),
                          TextSpan(
                            text: ' POIMEN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          TextSpan(text: ' App', style: TextStyle(color: textColor)),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(16.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AuthButton(
                        onPressed: () async {
                          await _handleLogin(context);
                        },
                        text: 'Login',
                      ),
                    ),
                  ],
                ),
              ),
            if (authState.errorMessage != null && authState.errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  authState.errorMessage!,
                  style: TextStyle(color: Colors.red[700]),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    log('Initiating login process');
    final authState = Provider.of<AuthState>(context, listen: false);

    final success = await authState.login();

    if (success && mounted) {
      log('Login successful, navigating to profile selection');
      Navigator.of(context).pushNamedAndRemoveUntil('/profile-choose', (route) => false);
    }
  }
}
