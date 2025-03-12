import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is OperationException) {
      if (error.linkException != null) {
        final linkException = error.linkException;

        // Handle network errors
        if (linkException is NetworkException) {
          return 'Network error: Unable to connect to the server';
        }

        // Handle timeout errors
        if (linkException.toString().contains('TimeoutException')) {
          return 'Connection timeout: Server took too long to respond';
        }

        return 'Connection error: ${linkException.toString()}';
      }

      // Handle GraphQL errors
      if (error.graphqlErrors.isNotEmpty) {
        return 'GraphQL error: ${error.graphqlErrors.map((e) => e.message).join(", ")}';
      }

      return 'Unknown GraphQL error occurred';
    }

    return 'Error: ${error.toString()}';
  }

  static void logError(String context, dynamic error) {
    final errorMsg = getErrorMessage(error);
    debugPrint('[$context] $errorMsg');

    // Log stack trace in debug mode
    if (kDebugMode && error is Error) {
      debugPrintStack(stackTrace: error.stackTrace);
    }
  }
}
