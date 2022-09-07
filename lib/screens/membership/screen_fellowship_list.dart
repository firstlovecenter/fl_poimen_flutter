import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipMembershipScreen extends StatelessWidget {
  const FellowshipMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getFellowshipMembers,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Members',
      bodyFunction: (data) {
        Widget body;

        final fellowship = ChurchForMemberList.fromJson(data?['fellowships'][0]);

        body = ChurchMembershipList(church: fellowship);
        var returnValues = GQLContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Membership',
          ),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
