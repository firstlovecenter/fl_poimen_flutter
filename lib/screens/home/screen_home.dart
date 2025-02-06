import 'package:flutter/material.dart';
import 'package:poimen/screens/home/gql_home_screen.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/widget_body_home_screen.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.read<SharedState>();
    var church = churchState.church;
    var query = getFellowshipHomeScreen;

    String pluralName = 'bacentas';

    if (church.typename == 'Bacenta') {
      pluralName = 'bacentas';
      query = getBacentaHomeScreen;
    }
    if (church.typename == 'Governorship') {
      pluralName = 'governorships';
      query = getGovernorshipHomeScreen;
    }
    if (church.typename == 'Council') {
      pluralName = 'councils';
      query = getCouncilHomeScreen;
    }
    if (church.typename == 'Stream') {
      pluralName = 'streams';
      query = getStreamHomeScreen;
    }
    if (church.typename == 'Campus') {
      pluralName = 'campuses';
      query = getCampusHomeScreen;
    }

    if (church.typename == 'Hub') {
      pluralName = 'hubs';
      query = getHubHomeScreen;
    }

    if (church.typename == 'HubCouncil') {
      pluralName = 'hubCouncils';
      query = getHubCouncilHomeScreen;
    }

    if (church.typename == 'Ministry') {
      pluralName = 'ministries';
      query = getMinistryHomeScreen;
    }

    if (church.typename == 'CreativeArts') {
      pluralName = 'creativeArts';
      query = getCreativeArtsHomeScreen;
    }

    return GQLQueryContainer(
      query: query,
      variables: {'id': church.id},
      defaultPageTitle: 'Home',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final church = HomeScreenChurch.fromJson(data?[pluralName][0]);

        body = HomeScreenBody(church: church);

        return GQLQueryContainerReturnValue(
          body: body,
        );
      },
    );
  }
}
