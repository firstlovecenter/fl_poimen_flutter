import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/services/auth_service.dart';

// final String host = kIsWeb
//     ? 'http://localhost:4001'
//     : Platform.isAndroid
//         ? 'http://10.0.2.2'
//         : 'https://poimen.firstlovecenter.com';

const String host = apiEndpoint;

final HttpLink httpLink = HttpLink(
  '$host/graphql',
);
final authToken = AuthService.instance.auth0AccessToken.toString();

final AuthLink authLink = AuthLink(
  getToken: () async => 'Bearer $authToken',
);

final Link link = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
    link: link,
  ),
);
