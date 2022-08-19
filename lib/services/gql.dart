import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/services/auth_service.dart';

final String host = kIsWeb
    ? 'localhost'
    : Platform.isAndroid
        ? '10.0.2.2'
        : 'localhost';

final HttpLink httpLink = HttpLink(
  'http://$host:4001/graphql',
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
