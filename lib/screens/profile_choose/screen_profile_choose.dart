import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final bool _isLoading = false;

  // Method to safely update user profile outside of build method
  void _updateUserProfile(Profile user, BuildContext context) {
    log('Updating user profile in state: ${user.firstName} ${user.lastName}');
    final authState = Provider.of<AuthState>(context, listen: false);
    final sharedState = Provider.of<SharedState>(context, listen: false);

    // Update both states to ensure backward compatibility
    authState.setUserProfile(user);
    sharedState.userProfile = user;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SharedState>();
    final authState = context.watch<AuthState>();

    if (authState.isLoading || _isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authState.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(authState.errorMessage!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      );
    }

    if (!authState.isAuthenticated) {
      log('ProfileChooseScreen: No valid authentication found');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Authentication data not found. Please login again.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return GQLQueryContainer(
      query: getUserRoles,
      variables: {'id': authState.authId},
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
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                    },
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            ),
          );
        }

        final user = Profile.fromJson(data['members'][0]);

        // Safely update user profile after the build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateUserProfile(user, context);
        });

        // Get version from AuthState first, fallback to SharedState
        final String version =
            authState.appVersion.isNotEmpty ? authState.appVersion : state.version;

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
