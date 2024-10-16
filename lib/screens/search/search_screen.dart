import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/search/gql_search_screen.dart';
import 'package:poimen/screens/search/models_search.dart';
import 'package:poimen/screens/search/widget_search_screen.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/member_tile.dart';
import 'package:poimen/widgets/no_data.dart';
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
    var churchState = context.watch<SharedState>();
    var church = churchState.church;

    var query = searchFellowship;
    String pluralName = 'fellowships';

    if (church.typename == 'Fellowship') {
      pluralName = 'fellowships';
      query = searchFellowship;
    }
    if (church.typename == 'Bacenta') {
      pluralName = 'bacentas';
      query = searchBacenta;
    }
    if (church.typename == 'Governorship') {
      pluralName = 'governorships';
      query = searchGovernorship;
    }
    if (church.typename == 'Council') {
      pluralName = 'councils';
      query = searchCouncil;
    }
    if (church.typename == 'Stream') {
      pluralName = 'streams';
      query = searchStream;
    }
    if (church.typename == 'Campus') {
      pluralName = 'campuses';
      query = searchCampus;
    }

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          church: church,
          pageTitle: 'Search',
        ),
      ),
      body: Column(
        children: [
          SearchFieldWidget(query: query),
          Query(
              options: QueryOptions(
                document: query,
                variables: {'id': church.id, 'searchKey': churchState.searchKey},
              ),
              builder: (
                QueryResult result, {
                VoidCallback? refetch,
                FetchMore? fetchMore,
              }) {
                if (result.hasException) {
                  return AlertBox(
                    type: AlertType.error,
                    message: getGQLException(result.exception),
                    onRetry: () => refetch!(),
                  );
                } else if (result.isLoading || result.data == null) {
                  return const Column(
                    children: [
                      Padding(padding: EdgeInsets.all(50)),
                      CircularProgressIndicator(),
                    ],
                  );
                } else {
                  final church = ChurchForSearchList.fromJson(result.data?[pluralName][0]);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      ...noDataChecker(church.memberSearch.map((member) {
                        return memberTile(context, member);
                      }).toList()),
                    ]),
                  );
                }
              })
        ],
      ),
    );
  }
}
