import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyMembershipScreen extends StatelessWidget {
  const ConstituencyMembershipScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getConstituencyMembers,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Members',
      bodyFunction: (data) {
        Widget body;

        final constituency = ChurchForMemberList.fromJson(data?['constituencies'][0]);

        body = ChurchMembershipList(church: constituency);
        var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              church: constituency,
              pageTitle: 'Membership',
            ),
            body: body);

        return returnValues;
      },
    );
  }
}
