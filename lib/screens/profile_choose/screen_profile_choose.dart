import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poimen/screens/profile_choose/gql_profile_choose.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_choose.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/auth_state.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

bool currentVersionValid(minimumVersion, currentVersion) {
  int majorMinimumVersion = int.parse(minimumVersion.split('.')[0]);
  int minorMinimumVersion = int.parse(minimumVersion.split('.')[1]);
  int patchMinimumVersion = int.parse(minimumVersion.split('.')[2]);

  int majorCurrentVersion = int.parse(currentVersion.split('.')[0]);
  int minorCurrentVersion = int.parse(currentVersion.split('.')[1]);
  int patchCurrentVersion = int.parse(currentVersion.split('.')[2]);

  if (majorCurrentVersion < majorMinimumVersion) {
    return false;
  } else if (minorCurrentVersion < minorMinimumVersion) {
    return false;
  } else if (patchCurrentVersion < patchMinimumVersion) {
    return false;
  } else {
    return true;
  }
}

void parseIdToken(String idToken) {
  final parts = idToken.split(r'.');
  assert(parts.length == 3);

  final Map<String, dynamic> json = jsonDecode(
    utf8.decode(
      base64Url.decode(
        base64Url.normalize(parts[1]),
      ),
    ),
  );

  print(json);
}

class ProfileChooseScreen extends StatefulWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);

  @override
  State<ProfileChooseScreen> createState() => _ProfileChooseScreenState();
}

class _ProfileChooseScreenState extends State<ProfileChooseScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _accessToken;
  String? _authId;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAuthData();
  }

  Future<void> _initializeAuthData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Using Future.wait to fetch both values in parallel
      final results = await Future.wait([
        _secureStorage.read(key: 'accessToken'),
        _secureStorage.read(key: 'authId'),
      ]);

      final accessToken = results[0];
      final authId = results[1];

      if (accessToken == null || authId == null) {
        debugPrint('Missing auth data. Token: ${accessToken != null}, ID: ${authId != null}');
        setState(() {
          _errorMessage = 'Authentication data is missing. Please log in again.';
        });
      }

      setState(() {
        _accessToken = accessToken;
        _authId = authId;
        _isLoading = false;
      });

      if (_accessToken != null && _authId != null) {
        debugPrint('Auth data loaded. ID: $_authId');
      } else {
        debugPrint('No valid authentication data found.');
      }
    } catch (e) {
      debugPrint('Error initializing auth data: $e');
      setState(() {
        _errorMessage = 'Failed to load authentication data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SharedState>();
    final authState = Provider.of<AuthState>(context, listen: false);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _initializeAuthData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_authId == null) {
      return const Scaffold(
        body: Center(child: Text('Authentication data not found. Please login again.')),
      );
    }

    return GQLQueryContainer(
      query: getUserRoles,
      variables: {'id': _authId},
      defaultPageTitle: 'Profile Selection',
      bodyFunction: (data, [fetchMore]) {
        if (data == null || data['members'] == null || data['members'].isEmpty) {
          return GQLQueryContainerReturnValue(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('User profile not found. Please try again.'),
                  ElevatedButton(
                    onPressed: _initializeAuthData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final user = Profile.fromJson(data['members'][0]);

        // Store the user profile in AuthState instead of just SharedState
        log('Storing user profile in AuthState: ${user.firstName} ${user.lastName}');
        Future.microtask(() {
          // Update both states to ensure backward compatibility during transition
          authState.setUserProfile(user);
          Provider.of<SharedState>(context, listen: false).userProfile = user;
        });

        final version = state.version;

        // Conditionally render body based on version validity and platform
        if (!kIsWeb && !currentVersionValid(data['minimumRequiredVersion'], version)) {
          return _buildUpdatePrompt();
        }

        return GQLQueryContainerReturnValue(
          body: ProfileChooseWidget(user: user),
        );
      },
    );
  }

  GQLQueryContainerReturnValue _buildUpdatePrompt() {
    return GQLQueryContainerReturnValue(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please update your app to the latest version'),
            TextButton(
              onPressed: () async {
                final url = Platform.isAndroid
                    ? 'https://play.google.com/store/apps/details?id=io.firstlovecenter.poimen'
                    : 'https://apps.apple.com/gh/app/flc-poimen/id6443637787';
                final Uri launchUri = Uri.parse(url);

                if (await canLaunchUrl(launchUri)) {
                  final launched = await launchUrl(
                    launchUri,
                    mode: LaunchMode.externalNonBrowserApplication,
                  );
                  if (!launched) {
                    await launchUrl(
                      launchUri,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                } else {
                  debugPrint('Could not launch $url');
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
