import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class StreamMembershipList extends StatelessWidget {
  const StreamMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getStreamMembers,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'Stream Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final stream = ChurchForMemberList.fromJson(data?['streams'][0]);

        pageTitle = '${stream.name} Stream Membership';

        body = ChurchMembershipList(church: stream);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
