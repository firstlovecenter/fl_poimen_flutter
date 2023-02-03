import 'package:flutter/material.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/widgets/auth_button.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    initAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      body: Center(
        // in the middle of the parent.
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
                          ]),
                    ),
                    const Padding(padding: EdgeInsets.all(16.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AuthButton(
                        onPressed: loginAction,
                        text: 'Login',
                      ),
                    )
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
      name = AuthService.instance.idToken?.name;
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
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }
}
