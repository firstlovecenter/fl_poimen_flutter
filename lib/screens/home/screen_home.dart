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
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    var query = getFellowshipHomeScreen;
    String pluralName = 'fellowships';

    if (church.typename == 'Fellowship') {
      pluralName = 'fellowships';
      query = getFellowshipHomeScreen;
    }
    if (church.typename == 'Bacenta') {
      pluralName = 'bacentas';
      query = getBacentaHomeScreen;
    }
    if (church.typename == 'Constituency') {
      pluralName = 'constituencies';
      query = getConstituencyHomeScreen;
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

    return GQLQueryContainer(
      query: query,
      variables: {'id': church.id},
      defaultPageTitle: 'Home',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final church = HomeScreenChurch.fromJson(data?[pluralName]?[0]);

        body = HomeScreenBody(church: church);

        return GQLQueryContainerReturnValue(
          body: body,
        );
      },
    );
  }
}
