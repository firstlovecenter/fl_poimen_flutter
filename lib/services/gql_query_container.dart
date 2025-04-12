import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';

class GQLQueryContainer extends StatefulWidget {
  final dynamic query;
  final Map<String, dynamic> variables;
  final String defaultPageTitle;
  final Function bodyFunction;
  final Widget? bottomNavBar;
  final bool? infiniteScroll;
  final Widget? loadingWidget;

  const GQLQueryContainer({
    Key? key,
    required this.query,
    required this.variables,
    required this.defaultPageTitle,
    required this.bodyFunction,
    this.infiniteScroll,
    this.bottomNavBar,
    this.loadingWidget,
  }) : super(key: key);

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
        Widget? pageTitle = ListTile(
            title: Text(
          widget.defaultPageTitle,
          style: const TextStyle(color: Colors.white),
        ));
        Widget body;

        if (result.hasException) {
          body = _handleQueryError(result.exception);
        } else if (widget.infiniteScroll != true && (result.isLoading || result.data == null)) {
          body = widget.loadingWidget ?? const LoadingScreen();
        } else {
          // Handle both old and new function signatures to maintain backward compatibility
          GQLQueryContainerReturnValue res;

          try {
            // Try new signature with fetchMore
            res = widget.bodyFunction(result.data, fetchMore);
          } catch (e) {
            try {
              // Fall back to old signature without fetchMore
              res = widget.bodyFunction(result.data);
            } catch (e2) {
              // If both fail, show error
              body = _handleQueryError("Error calling bodyFunction: $e2");
              return Scaffold(
                appBar: pageTitle != null ? AppBar(title: pageTitle) : null,
                body: body,
                bottomNavigationBar: widget.bottomNavBar,
              );
            }
          }

          pageTitle = res.pageTitle;
          body = res.body;
        }

        return Scaffold(
          appBar: pageTitle != null
              ? AppBar(
                  title: pageTitle,
                )
              : null,
          body: body,
          bottomNavigationBar: widget.bottomNavBar,
        );
      },
    );
  }

  Widget _handleQueryError(dynamic error) {
    String errorMessage = 'An unknown error occurred';

    if (error is OperationException) {
      if (error.linkException != null) {
        errorMessage = 'Network error: ${error.linkException.toString()}';
      } else if (error.graphqlErrors.isNotEmpty) {
        errorMessage = 'GraphQL error: ${error.graphqlErrors.map((e) => e.message).join(", ")}';
      }
    } else {
      errorMessage = 'Error: ${error.toString()}';
    }

    debugPrint('GQLQueryContainer error: $errorMessage');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Refresh the query
              // You'll need to implement a way to refresh the query here
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class GQLQueryContainerReturnValue {
  final PageTitle? pageTitle;
  final Widget body;

  GQLQueryContainerReturnValue({this.pageTitle, required this.body});
}
