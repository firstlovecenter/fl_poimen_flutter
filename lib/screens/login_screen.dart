import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart' hide LinearGradient;
import 'package:flutter/material.dart' as material show LinearGradient;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/state/auth_state.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/animated_background.dart';
import 'package:poimen/widgets/auth_button.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 1200;

    // Theme detection
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final brandColor = PoimenTheme.brand;
    final scaffoldColor = isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F8);
    final cardColor = isDark ? PoimenTheme.darkCardColor : Colors.white;
    final shadowColor = isDark ? Colors.black54 : Colors.black12;

    // Get state providers
    final authState = context.watch<AuthState>();

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: AnimatedBackground(
        primaryColor: brandColor,
        secondaryColor: brandColor.withRed((brandColor.red + 40).clamp(0, 255)),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 500 : (isTablet ? 450 : double.infinity),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (authState.isLoading)
                        const LoadingScreen()
                      else
                        Card(
                          elevation: 8,
                          shadowColor: shadowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // Logo Animation
                                Container(
                                  height: isTablet ? 280 : 220,
                                  width: isTablet ? 280 : 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: RiveAnimation.asset(
                                      'assets/animations/spinning_logo.riv',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Welcome Text with Gradient
                                ShaderMask(
                                  shaderCallback: (bounds) => material.LinearGradient(
                                    colors: [
                                      brandColor,
                                      brandColor.withRed((brandColor.red + 40).clamp(0, 255)),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds),
                                  child: Text(
                                    'POIMEN',
                                    style: TextStyle(
                                      fontSize: isTablet ? 40 : 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Welcome to the Poimen App',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    color: textColor.withOpacity(0.8),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),

                                // Login Button
                                AuthButton(
                                  onPressed: () => _handleLogin(context),
                                  text: 'Sign In',
                                  icon: FontAwesomeIcons.doorOpen,
                                  isLoading: authState.isLoading,
                                ),

                                // App Version & Copyright
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Text(
                                    '© ${DateTime.now().year} First Love Center',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor.withOpacity(0.5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Error Message
                      if (authState.errorMessage != null && authState.errorMessage!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red[700],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    authState.errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
