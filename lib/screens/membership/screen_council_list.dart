import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:provider/provider.dart';

class CouncilMembershipList extends StatelessWidget {
  const CouncilMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getCouncilMembers,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final council = ChurchForMemberList.fromJson(data?['councils'][0]);

        pageTitle = '${council.name} Council Membership';

        body = ChurchMembershipList(church: council);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
