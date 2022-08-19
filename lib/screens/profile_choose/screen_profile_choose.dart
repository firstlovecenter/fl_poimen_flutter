import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/profile_choose/gql_profile_choose.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_card.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/auth_button.dart';

class ProfileChooseScreen extends StatelessWidget {
  // final userId;
  const ProfileChooseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authId = AuthService.instance.idToken?.userId;

    return Query(
      options: QueryOptions(document: getUserRoles, variables: {
        'id': authId,
      }),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        Widget body;
        String pageTitle = 'Profile Choose';

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception.toString(),
            onRetry: () => refetch!(),
          );
        } else if (result.isLoading && result.data != null) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final user = Profile.fromJson(result.data!['members'][0]);
          pageTitle = user.firstName;

          body = Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              children: [
                ...user.leadsFellowship.map((church) {
                  return ProfileCard(
                      church: church, level: 'Fellowship', role: 'Leader');
                }).toList(),
                ...user.leadsBacenta.map((church) {
                  return ProfileCard(
                      church: church, level: 'Bacenta', role: 'Leader');
                }).toList(),
                ...user.leadsConstituency.map((church) {
                  return ProfileCard(
                      church: church, level: 'Constituency', role: 'Leader');
                }).toList(),
                ...user.leadsCouncil.map((church) {
                  return ProfileCard(
                      church: church, level: 'Council', role: 'Leader');
                }).toList(),
                ...user.leadsGatheringService.map((church) {
                  return ProfileCard(
                      church: church,
                      level: 'Gathering Service',
                      role: 'Admin');
                }).toList(),
                ...user.isAdminForGatheringService.map((church) {
                  return ProfileCard(
                      church: church,
                      level: 'Gathering Service',
                      role: 'Admin');
                }).toList(),
              ],
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome ',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      pageTitle,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
                const Text('Which profile would you like to access?'),
                body,
                AuthButton(
                    text: 'Sign Out',
                    onPressed: () {
                      AuthService.instance.logout();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    }),
                const Padding(padding: EdgeInsets.all(6))
              ],
            ),
          ),
        );
      },
    );
  }
}
