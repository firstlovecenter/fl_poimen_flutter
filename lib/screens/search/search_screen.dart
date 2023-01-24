import 'package:flutter/material.dart';
import 'package:poimen/screens/search/gql_search_screen.dart';
import 'package:poimen/screens/search/models_search.dart';
import 'package:poimen/screens/search/widget_search_screen.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    var query = searchFellowship;
    String pluralName = 'fellowships';

    if (church.typename == 'Fellowship') {
      pluralName = 'fellowships';
      query = searchFellowship;
    }
    if (church.typename == 'Bacenta') {
      pluralName = 'bacentas';
      // query = getBacentaHomeScreen;
    }
    if (church.typename == 'Constituency') {
      pluralName = 'constituencies';
      // query = getConstituencyHomeScreen;
    }
    if (church.typename == 'Council') {
      pluralName = 'councils';
      // query = getCouncilHomeScreen;
    }
    if (church.typename == 'Stream') {
      pluralName = 'streams';
      // query = getStreamHomeScreen;
    }
    if (church.typename == 'GatheringService') {
      pluralName = 'gatheringServices';
      // query = getGatheringServiceHomeScreen;
    }

    return GQLQueryContainer(
      query: query,
      variables: {'id': church.id, 'searchKey': 'ed'},
      defaultPageTitle: 'Home',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final church = ChurchForSearchList.fromJson(data?[pluralName][0]);

        body = SearchScreenWidget(query: query);

        return GQLQueryContainerReturnValue(
          body: body,
          pageTitle: PageTitle(
            church: church,
            pageTitle: 'Search',
          ),
        );
      },
    );
  }
}
