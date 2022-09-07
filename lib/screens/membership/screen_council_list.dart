import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilMembershipScreen extends StatelessWidget {
  const CouncilMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getCouncilMembers,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Members',
      bodyFunction: (data) {
        Widget body;

        final council = ChurchForMemberList.fromJson(data?['councils'][0]);

        body = ChurchMembershipList(church: council);
        var returnValues = GQLContainerReturnValue(
            pageTitle: PageTitle(church: council, pageTitle: 'Membership'), body: body);

        return returnValues;
      },
    );
  }
}
