import 'dart:convert';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/models/auth0_id_token.dart';
import 'package:http/http.dart' as http;
import 'package:poimen/models/auth0_user.dart';

import 'dart:convert';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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
    if (kIsWeb) {
      final credentials = await auth0Web.onLoad();
      if (credentials != null) {
        auth0AccessToken = credentials.accessToken;
         profile = Auth0User(
            nickname: '',
            name: credentials.user.name ?? '',
            email: credentials.user.email ?? '',
            picture: '',
            updatedAt: '',
            sub: credentials.user.sub,
            roles: []);
        print('profile a rahi h--------------------$profile');
        return true;
      }
      return false;
    } else {
      final storedAccessToken = await secureStorage.read(key: 'accessToken');
      if (storedAccessToken != null) {
        auth0AccessToken = storedAccessToken;
        profile = await getUserDetails(storedAccessToken);
        return true;
      }
      return false;
    }
  }

  Future<String> login() async {
    try {
      if (kIsWeb) {
        print('web me dekhty h ion sahi h');
        await auth0Web.loginWithRedirect(
          redirectUrl: "http://localhost:3000/",
        );
        return 'Success';
      } else {
        final credentials =
            await auth0.webAuthentication().login(useHTTPS: true);
        auth0AccessToken = credentials.accessToken;
        profile = Auth0User(
            nickname: '',
            name: credentials.user.name ?? '',
            email: credentials.user.email ?? '',
            picture: '',
            updatedAt: '',
            sub: credentials.user.sub,
            roles: []);

        if (credentials.accessToken != null) {
          await secureStorage.write(
              key: 'accessToken', value: credentials.accessToken);
        }
        return 'Success';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login Error: $e');
      }
      return 'Login Failed: $e';
    }
  }

  Future<Auth0User> getUserDetails(String accessToken) async {
    final url = Uri.https(
      'flcadmin.us.auth0.com',
      '/userinfo',
    );
    print('--------getUserProfile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      print('check krnta ho');
      Auth0User user = Auth0User.fromJson(jsonDecode(response.body));
      print(user.roles);
      return Auth0User.fromJson(jsonDecode(response.body));
    } else {
      print('failed to et user details');
      throw Exception('Failed to get user details');
    }
  }

  Future<void> logout() async {
    if (kIsWeb) {
      await auth0Web.logout(returnToUrl: 'http://localhost:3000');
    } else {
      await auth0.webAuthentication().logout(useHTTPS: true);
      await secureStorage.delete(key: 'accessToken');
    }
    profile = null;
    auth0AccessToken = null;
  }
}
