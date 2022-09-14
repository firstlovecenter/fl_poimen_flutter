import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';

class GQLMutationContainer extends StatelessWidget {
  final dynamic query;
  final Map<String, dynamic> variables;
  final String defaultPageTitle;
  final Function(Map<String, dynamic>?) bodyFunction;

  const GQLMutationContainer(
      {Key? key,
      required this.query,
      required this.variables,
      required this.defaultPageTitle,
      required this.bodyFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(document: query),
      builder: (RunMutation runMutation, QueryResult? result) {
        Widget pageTitle = Text(defaultPageTitle);
        Widget body;

        if (result == null) {
          return const LoadingScreen();
        }

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception?.graphqlErrors[0].message.toString() ??
                result.exception.toString(),
            onRetry: () => runMutation(variables),
          );
        } else if (result.isLoading || result.data == null) {
          body = const LoadingScreen();
        } else {
          GQLQueryContainerReturnValue res = bodyFunction(result.data);
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
          body: Column(
            children: [
              body,
              ElevatedButton(
                  onPressed: () => runMutation(variables), child: const Text('Run Mutation'))
            ],
          ),
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
