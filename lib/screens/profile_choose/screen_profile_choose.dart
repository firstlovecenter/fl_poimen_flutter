import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/gql_profile_choose.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/screens/profile_choose/widget_profile_choose.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class ProfileChooseScreen extends StatelessWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authId = AuthService.instance.idToken?.userId;
    var userState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getUserRoles,
      variables: {
        'id': authId,
      },
      defaultPageTitle: 'Profile Selection',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final user = Profile.fromJson(data?['members'][0]);

        body = ProfileChooseWidget(user: user);

        return GQLQueryContainerReturnValue(
          body: body,
        );
      },
    );
  }
}
