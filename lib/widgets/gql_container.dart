import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/screen_fellowship_list.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';

class GQLContainer extends StatelessWidget {
  final query;
  Map<String, dynamic> variables = {};
  final Function bodyFunction;
  final String defaultPageTitle;

  GQLContainer(
      {Key? key,
      required this.query,
      required this.variables,
      required this.bodyFunction,
      required this.defaultPageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: query, variables: variables),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        String pageTitle = defaultPageTitle;
        Widget body;

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception.toString(),
            onRetry: () => refetch!(),
          );
        } else if (result.isLoading || result.data == null) {
          body = const LoadingScreen();
        } else {
          GQLContainerReturnValue res = bodyFunction(result.data);
          pageTitle = res.pageTitle;
          body = res.body;
        }

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pageTitle),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}

class GQLContainerReturnValue {
  final String pageTitle;
  final Widget body;

  GQLContainerReturnValue({required this.pageTitle, required this.body});
}
