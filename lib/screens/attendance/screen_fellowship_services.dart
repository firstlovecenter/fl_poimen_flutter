import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/gql_services_list.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/widget_services_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipServicesScreen extends StatelessWidget {
  const FellowshipServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
        query: getFellowshipServices,
        variables: {'id': churchState.fellowshipId},
        defaultPageTitle: 'Fellowship Services',
        bodyFunction: (data) {
          Widget body;

          final fellowship = ChurchForServicesList.fromJson(data?['fellowships'][0]);

          body = ChurchServicesList(church: fellowship);

          return GQLContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Services', church: fellowship),
            body: body,
          );
        });
  }
}
