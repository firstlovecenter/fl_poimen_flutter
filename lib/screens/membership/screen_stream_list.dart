import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_query_container.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class StreamMembershipScreen extends StatelessWidget {
  const StreamMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getStreamMembers,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'Stream Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;

        final stream = ChurchForMemberList.fromJson(data?['streams'][0]);

        body = ChurchMembershipList(church: stream);
        var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              pageTitle: 'Membership',
              church: stream,
            ),
            body: body);

        return returnValues;
      },
    );
  }
}
