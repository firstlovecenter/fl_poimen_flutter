import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poimen/services/auth_service.dart';
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
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String? name;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await initAction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? Colors.white : Colors.black;
    var state = context.watch<SharedState>();
    print('Check the state ${state.version}');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isProgressing)
              const LoadingScreen()
            else if (!isLoggedIn)
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
                        onPressed: () {
                          loginAction();
                        },
                        text: 'Login',
                      ),
                    ),
                  ],
                ),
              )
            else
              Text('Welcome $name'),
            if (errorMessage.isNotEmpty) Text(errorMessage),
          ],
        ),
      ),
    );
  }

  setSuccessAuthState() async {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.profile?.name;
    });

    Navigator.of(context).pushNamedAndRemoveUntil('/profile-choose', (route) => false);
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
        errorMessage = message;
      });
    }
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    log('Auth is Done $isAuth');
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }
}
