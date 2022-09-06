import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_member_details.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:provider/provider.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getMemberDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Details',
      bodyFunction: (data) {
        var returnValues = GQLContainerReturnValue(
          pageTitle: 'Member Details',
          body: const Text('Member Details'),
        );

        return returnValues;
      },
    );
  }
}
