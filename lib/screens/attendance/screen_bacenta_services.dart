import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/gql_services_list.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/widget_services_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaServicesScreen extends StatelessWidget {
  const BacentaServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
        query: getBacentaServices,
        variables: {'id': churchState.bacentaId},
        defaultPageTitle: 'Bacenta Services',
        bodyFunction: (data) {
          Widget body;

          final bacenta = ChurchForBussingList.fromJson(data?['bacentas'][0]);

          body = ChurchServicesList(services: bacenta.bussing);

          return GQLContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Bussing', church: bacenta),
            body: body,
          );
        });
  }
}
