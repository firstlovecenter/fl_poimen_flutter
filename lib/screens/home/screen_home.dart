import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart'; // Add this import for FetchMoreOptions
import 'package:poimen/screens/home/gql_home_screen.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/widget_body_home_screen.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _pluralName;
  late dynamic _query;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the SharedState here safely instead of in build
    final churchState = Provider.of<SharedState>(context, listen: true);
    final church = churchState.church;

    _initializeQueryDetails(church);
    _isInitialized = true;
  }

  void _initializeQueryDetails(dynamic church) {
    _pluralName = 'bacentas';
    _query = getBacentaHomeScreen;

    switch (church.typename) {
      case 'Bacenta':
        _pluralName = 'bacentas';
        _query = getBacentaHomeScreen;
        break;
      case 'Governorship':
        _pluralName = 'governorships';
        _query = getGovernorshipHomeScreen;
        break;
      case 'Council':
        _pluralName = 'councils';
        _query = getCouncilHomeScreen;
        break;
      case 'Stream':
        _pluralName = 'streams';
        _query = getStreamHomeScreen;
        break;
      case 'Campus':
        _pluralName = 'campuses';
        _query = getCampusHomeScreen;
        break;
      case 'Hub':
        _pluralName = 'hubs';
        _query = getHubHomeScreen;
        break;
      case 'HubCouncil':
        _pluralName = 'hubCouncils';
        _query = getHubCouncilHomeScreen;
        break;
      case 'Ministry':
        _pluralName = 'ministries';
        _query = getMinistryHomeScreen;
        break;
      case 'CreativeArts':
        _pluralName = 'creativeArts';
        _query = getCreativeArtsHomeScreen;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the church data without triggering a rebuild
    final churchState = Provider.of<SharedState>(context, listen: false);
    final church = churchState.church;

    // Show loading if not initialized or church is null
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GQLQueryContainer(
      query: _query,
      variables: {'id': church.id},
      defaultPageTitle: 'Home',
      bodyFunction: (data, [fetchMore]) {
        try {
          // Handle null or empty data
          if (data == null || data[_pluralName] == null || data[_pluralName].isEmpty) {
            return GQLQueryContainerReturnValue(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No data found. Please try again.'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (fetchMore != null) {
                          // Use fetchMore with appropriate options
                          fetchMore(FetchMoreOptions(
                            variables: {'id': church.id},
                            updateQuery: (previousResultData, fetchMoreResultData) {
                              return fetchMoreResultData;
                            },
                          ));
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final churchData = HomeScreenChurch.fromJson(data[_pluralName][0]);
          return GQLQueryContainerReturnValue(
            body: HomeScreenBody(church: churchData),
          );
        } catch (e) {
          debugPrint('Error in HomeScreen: $e');
          return GQLQueryContainerReturnValue(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading data: ${e.toString()}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (fetchMore != null) {
                        // Use fetchMore with appropriate options
                        fetchMore(FetchMoreOptions(
                          variables: {'id': church.id},
                          updateQuery: (previousResultData, fetchMoreResultData) {
                            return fetchMoreResultData;
                          },
                        ));
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
