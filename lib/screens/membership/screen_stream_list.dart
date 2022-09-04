import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class StreamMembershipList extends StatelessWidget {
  const StreamMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return Query(
      options: QueryOptions(document: getStreamMembers, variables: {
        'id': churchState.streamId,
      }),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        Widget body;
        String pageTitle = 'Stream Members';

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception.toString(),
            onRetry: () => refetch!(),
          );
        } else if (result.isLoading || result.data == null) {
          body = const LoadingScreen();
        } else {
          final stream = ChurchForMemberList.fromJson(result.data?['streams'][0]);

          pageTitle = '${stream.name} Stream Membership';

          body = ChurchMembershipList(church: stream);
        }

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pageTitle),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}
