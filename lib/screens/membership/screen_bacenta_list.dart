import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:provider/provider.dart';

class BacentaMembershipList extends StatelessWidget {
  const BacentaMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getBacentaMembers,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final bacenta = ChurchForMemberList.fromJson(data?['bacentas'][0]);

        pageTitle = '${bacenta.name} Bacenta Membership';

        body = ChurchMembershipList(church: bacenta);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
