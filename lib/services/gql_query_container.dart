import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';

class GQLQueryContainer extends StatefulWidget {
  final dynamic query;
  final Map<String, dynamic> variables;
  final String defaultPageTitle;
  final Function(Map<String, dynamic>?) bodyFunction;
  final Widget? bottomNavBar;

  const GQLQueryContainer(
      {Key? key,
      required this.query,
      required this.variables,
      required this.defaultPageTitle,
      required this.bodyFunction,
      this.bottomNavBar})
      : super(key: key);

  @override
  State<GQLQueryContainer> createState() => _GQLQueryContainerState();
}

class _GQLQueryContainerState extends State<GQLQueryContainer> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: widget.query, variables: widget.variables),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        Widget pageTitle = Text(widget.defaultPageTitle);
        Widget body;

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception?.graphqlErrors[0].message.toString() ??
                result.exception.toString(),
            onRetry: () => refetch!(),
          );
        } else if (result.isLoading || result.data == null) {
          body = const LoadingScreen();
        } else {
          GQLQueryContainerReturnValue res = widget.bodyFunction(result.data);
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
          bottomNavigationBar: widget.bottomNavBar,
        );
      },
    );
  }
}

class GQLQueryContainerReturnValue {
  final PageTitle pageTitle;
  final Widget body;

  GQLQueryContainerReturnValue({required this.pageTitle, required this.body});
}
