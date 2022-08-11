import 'package:poimen/widgets/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/models/model.dart';
import 'package:poimen/widgets/business_list_tile.dart';
import 'package:poimen/widgets/menu_drawer.dart';

final getBusinessesQuery = gql("""
  query {
    businesses {
      businessId,
      name,
      city,
      state,
      avgStars
    }
  }
""");

class BusinessListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Businesses'),
      ),
      drawer: MenuDrawer(),
      body: Query(
        options: QueryOptions(
          document: getBusinessesQuery,
        ),
        builder: (
          QueryResult result, {
          Future<QueryResult?> Function()? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return AlertBox(
              type: AlertType.error,
              text: result.exception.toString(),
              onRetry: () => refetch!(),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final businessesRes = result.data!['businesses']
              .map((biz) => Business.fromJson(biz))
              .toList();

          if (businessesRes.length == 0) {
            return AlertBox(
              type: AlertType.info,
              text: 'No businesses to show.',
              onRetry: refetch!,
            );
          }

          return RefreshIndicator(
            onRefresh: () => refetch!(),
            child: Material(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return BusinessListTile(business: businessesRes[index]);
                },
                itemCount: businessesRes.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
