import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poimen/screens/membership/idl/gql_fellowship_idls.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/screens/membership/idl/widget_idl_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipIDLScreen extends StatelessWidget {
  const FellowshipIDLScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getFellowshipIdls,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship IDL List',
      bodyFunction: (data) {
        Widget body;

        final fellowship = ChurchForIdlList.fromJson(data?['fellowships'][0]);

        body = ChurchIdlList(church: fellowship);

        return GQLContainerReturnValue(
            pageTitle: PageTitle(
              church: fellowship,
              pageTitle: 'IDL List',
            ),
            body: body);
      },
    );
  }
}
