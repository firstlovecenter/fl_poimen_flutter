import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';

class GQLContainer extends StatelessWidget {
  final dynamic query;
  final Map<String, dynamic> variables;
  final String defaultPageTitle;
  final Function(Map<String, dynamic>?) bodyFunction;

  const GQLContainer(
      {Key? key,
      required this.query,
      required this.variables,
      required this.defaultPageTitle,
      required this.bodyFunction})
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
        Widget pageTitle = Text(defaultPageTitle);
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
                pageTitle,
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
  final PageTitle pageTitle;
  final Widget body;

  GQLContainerReturnValue({required this.pageTitle, required this.body});
}
