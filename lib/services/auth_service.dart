import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poimen/models/auth0_user.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();

  final auth0 = Auth0(
    'flcadmin.us.auth0.com',
    'KPaxujz8cW2KdhPHlRnHbBtueLd2JkWw',
  );
  final auth0Web = Auth0Web(
    'flcadmin.us.auth0.com',
    'fuux0wsg9lEZ5UayYnmPTCDngWug1grv',
  );

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Auth0User? profile;
  String? auth0AccessToken;

  Future<bool> init() async {
    try {
      if (kIsWeb) {
        try {
          final credentials = await auth0Web.onLoad();
          if (credentials != null) {
            auth0AccessToken = credentials.idToken;

            profile = Auth0User(
              nickname: '',
              name: credentials.user.name ?? '',
              email: credentials.user.email ?? '',
              picture: '',
              updatedAt: '',
              sub: credentials.user.sub,
              roles: [],
            );
            await secureStorage.write(
              key: 'accessToken',
              value: credentials.idToken,
            );
            await secureStorage.write(
              key: 'authId',
              value: profile!.sub,
            );
            log('Web auth initialized successfully');
            return true;
          }
          log('No credentials found on the web.');
          return false;
        } catch (e) {
          log('Error during web auth initialization: $e');
          return false;
        }
      } else {
        try {
          final accessToken = await secureStorage.read(key: 'accessToken');
          final authId = await secureStorage.read(key: 'authId');

          if (accessToken != null && authId != null) {
            auth0AccessToken = accessToken;
            log('Stored credentials found: authId=$authId');
            return true;
          }
          log('No stored credentials found on mobile.');
          return false;
        } catch (e) {
          log('Error reading stored credentials: $e');
          return false;
        }
      }
    } catch (e, stackTrace) {
      log('Error during authentication initialization: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  Future<String> login() async {
    try {
      if (kIsWeb) {
        await auth0Web.loginWithRedirect(
          redirectUrl: "http://localhost:3000/",
        );
        return 'Success';
      } else {
        final credentials = await auth0.webAuthentication().login(useHTTPS: true);
        auth0AccessToken = credentials.accessToken;

        if (credentials.user.sub.isEmpty) {
          throw Exception('Missing user ID in authentication response');
        }

        profile = Auth0User(
            nickname: '',
            name: credentials.user.name ?? '',
            email: credentials.user.email ?? '',
            picture: '',
            updatedAt: '',
            sub: credentials.user.sub,
            roles: []);

        await secureStorage.write(key: 'accessToken', value: credentials.idToken);
        await secureStorage.write(key: 'authId', value: profile!.sub);
        log('Mobile login successful, authId=${profile!.sub}');

        return 'Success';
      }
    } catch (e) {
      log('Login Error: $e', level: 1000);
      return 'Login Failed: $e';
    }
  }

  Future<void> logout() async {
    if (kIsWeb) {
      await auth0Web.logout(returnToUrl: 'http://localhost:3000');
    } else {
      await auth0.webAuthentication().logout(useHTTPS: true);
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'authId');
    }
    profile = null;
    auth0AccessToken = null;
  }
}
