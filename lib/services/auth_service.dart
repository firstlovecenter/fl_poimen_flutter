import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poimen/models/auth0_user.dart';
import 'package:poimen/state/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

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
      log('Initializing AuthService...');
      if (kIsWeb) {
        try {
          log('Running on Web platform - initializing web auth...');
          final credentials = await auth0Web.onLoad();
          if (credentials != null) {
            auth0AccessToken = credentials.idToken;
            log('Web auth credentials obtained successfully');

            // Create profile from credentials
            profile = Auth0User(
              nickname: credentials.user.nickname ?? '',
              name: credentials.user.name ?? '',
              email: credentials.user.email ?? '',
              picture: credentials.user.pictureUrl.toString(),
              updatedAt: '',
              sub: credentials.user.sub,
              roles: credentials.user.customClaims?['roles'] as List<String>? ?? [],
            );

            log('Web profile created: ${profile?.name}, ID: ${profile?.sub}');

            await secureStorage.write(
              key: 'accessToken',
              value: credentials.idToken,
            );
            await secureStorage.write(
              key: 'authId',
              value: profile!.sub,
            );

            // Store profile data in secure storage as JSON string
            await _saveProfileToStorage(profile!);

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
          log('Running on Mobile platform - checking stored credentials...');
          final accessToken = await secureStorage.read(key: 'accessToken');
          final authId = await secureStorage.read(key: 'authId');

          if (accessToken != null && authId != null) {
            auth0AccessToken = accessToken;
            log('Stored credentials found: authId=$authId');

            // Try to load profile from secure storage
            final loadedProfile = await _loadProfileFromStorage();
            if (loadedProfile != null) {
              profile = loadedProfile;
              log('Profile loaded from storage: ${profile?.name}, ID: ${profile?.sub}');
            } else {
              log('No profile data in storage, will need to fetch user info');
              // Try to fetch user info using the token
              try {
                // Fix the API call by passing the accessToken parameter
                final userProfile = await auth0.api.userProfile(accessToken: accessToken);
                log('User info fetched from API: ${userProfile.name}');
                profile = _createProfileFromCredentialUser(userProfile, authId);
                await _saveProfileToStorage(profile!);
              } catch (e) {
                log('Error fetching user info with token: $e');
                // Continue anyway since we have valid token
              }
            }

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
        log('Initiating web login flow...');
        await auth0Web.loginWithRedirect(
          redirectUrl: "http://localhost:3000/",
        );
        return 'Success';
      } else {
        log('Initiating mobile login flow...');
        final credentials = await auth0.webAuthentication().login(useHTTPS: true);
        auth0AccessToken = credentials.accessToken;

        log('Login successful, processing credentials...');
        log('ID token available: ${credentials.idToken.isNotEmpty}');
        log('Access token available: ${credentials.accessToken.isNotEmpty}');
        log('User info available: ${credentials.user}');

        if (credentials.user.sub.isEmpty) {
          throw Exception('Missing user ID in authentication response');
        }

        log('Creating user profile from auth response...');
        profile = Auth0User(
            nickname: credentials.user.nickname ?? '',
            name: credentials.user.name ?? '',
            email: credentials.user.email ?? '',
            picture: credentials.user.pictureUrl.toString(),
            updatedAt: '',
            sub: credentials.user.sub,
            roles: credentials.user.customClaims?['roles'] as List<String>? ?? []);

        log('Profile created: ${profile?.name}, Email: ${profile?.email}, ID: ${profile?.sub}');

        // Store tokens in secure storage
        await secureStorage.write(key: 'accessToken', value: credentials.idToken);
        await secureStorage.write(key: 'authId', value: profile!.sub);

        // Store profile data
        await _saveProfileToStorage(profile!);

        log('Mobile login successful, authId=${profile!.sub}');
        return 'Success';
      }
    } catch (e) {
      log('Login Error: $e', level: 1000);
      return 'Login Failed: $e';
    }
  }

  Future<void> logout([BuildContext? context]) async {
    log('Logging out...');
    if (kIsWeb) {
      await auth0Web.logout(returnToUrl: 'http://localhost:3000');
    } else {
      await auth0.webAuthentication().logout(useHTTPS: true);
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'authId');
      await secureStorage.delete(key: 'userProfile');

      // Clear profile data from storage
      final keys = await secureStorage.readAll();
      for (final key in keys.keys) {
        if (key.startsWith('profile_')) {
          await secureStorage.delete(key: key);
        }
      }

      log('Credentials cleared from storage');
    }

    // Clear profile data
    profile = null;
    auth0AccessToken = null;

    // Clear AuthState if context is provided
    if (context != null) {
      try {
        final authState = Provider.of<AuthState>(context, listen: false);
        authState.clearProfileData();
      } catch (e) {
        log('Error clearing AuthState: $e');
      }
    }

    log('Logout complete');
  }

  // Helper method to save profile to storage
  Future<void> _saveProfileToStorage(Auth0User userProfile) async {
    try {
      log('Saving profile to storage...');
      final Map<String, dynamic> profileData = {
        'nickname': userProfile.nickname,
        'name': userProfile.name,
        'email': userProfile.email,
        'picture': userProfile.picture,
        'updatedAt': userProfile.updatedAt,
        'sub': userProfile.sub,
        'roles': userProfile.roles,
      };

      // Convert map entries to string format
      final Map<String, String> storageMap = {};
      profileData.forEach((key, value) {
        if (value is List) {
          storageMap[key] = value.join(',');
        } else {
          storageMap[key] = value?.toString() ?? '';
        }
      });

      // Store each field separately
      for (var entry in storageMap.entries) {
        await secureStorage.write(key: 'profile_${entry.key}', value: entry.value);
      }
      log('Profile saved to storage successfully');
    } catch (e) {
      log('Error saving profile to storage: $e');
    }
  }

  // Helper method to load profile from storage
  Future<Auth0User?> _loadProfileFromStorage() async {
    try {
      log('Loading profile from storage...');
      final nickname = await secureStorage.read(key: 'profile_nickname') ?? '';
      final name = await secureStorage.read(key: 'profile_name') ?? '';
      final email = await secureStorage.read(key: 'profile_email') ?? '';
      final picture = await secureStorage.read(key: 'profile_picture') ?? '';
      final updatedAt = await secureStorage.read(key: 'profile_updatedAt') ?? '';
      final sub = await secureStorage.read(key: 'profile_sub') ?? '';
      final rolesStr = await secureStorage.read(key: 'profile_roles') ?? '';

      // If we don't have sub, it means profile wasn't saved properly
      if (sub.isEmpty) {
        log('No profile sub found in storage');
        return null;
      }

      final roles = rolesStr.isEmpty ? <String>[] : rolesStr.split(',');

      log('Profile loaded from storage: $name, ID: $sub');
      return Auth0User(
        nickname: nickname,
        name: name,
        email: email,
        picture: picture,
        updatedAt: updatedAt,
        sub: sub,
        roles: roles,
      );
    } catch (e) {
      log('Error loading profile from storage: $e');
      return null;
    }
  }

  // Create profile from Credentials.user object
  Auth0User _createProfileFromCredentialUser(UserProfile userProfile, String sub) {
    return Auth0User(
      nickname: userProfile.nickname ?? '',
      name: userProfile.name ?? '',
      email: userProfile.email ?? '',
      picture: userProfile.pictureUrl.toString(),
      updatedAt: '',
      sub: sub,
      roles: [],
    );
  }
}
