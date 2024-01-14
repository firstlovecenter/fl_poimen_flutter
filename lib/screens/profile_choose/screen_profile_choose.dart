import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/gql_profile_choose.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_choose.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/gql_query_container.dart';
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

class ProfileChooseScreen extends StatelessWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authId = AuthService.instance.idToken?.userId;
    var state = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getUserRoles,
      variables: {
        'id': authId,
      },
      defaultPageTitle: 'Profile Selection',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final user = Profile.fromJson(data?['members'][0]);
        final version = state.version;
        body = ProfileChooseWidget(user: user);

        if (!currentVersionValid(data?['minimumRequiredVersion'], version)) {
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Please update your app to the latest version'),
                TextButton(
                  onPressed: () async {
                    String url = '';
                    if (Platform.isAndroid) {
                      url =
                          'https://play.google.com/store/apps/details?id=io.firstlovecenter.poimen';
                    } else if (Platform.isIOS) {
                      url = 'https://apps.apple.com/gh/app/flc-poimen/id6443637787';
                    }
                    final Uri launchUri = Uri.parse(url);

                    if (await canLaunchUrl(launchUri)) {
                      final bool nativeAppLaunchSucceeded = await launchUrl(
                        launchUri,
                        mode: LaunchMode.externalNonBrowserApplication,
                      );

                      if (!nativeAppLaunchSucceeded) {
                        await launchUrl(
                          launchUri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          );
        }

        return GQLQueryContainerReturnValue(
          body: body,
        );
      },
    );
  }
}
