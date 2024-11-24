import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/helpers/constants.dart';
import 'package:poimen/services/auth_service.dart';

final String host = apiEndpoint == 'http://localhost:4001' && Platform.isAndroid
    ? 'http://10.0.2.2:4001'
    : apiEndpoint;

final String currentHost = kDebugMode ? host : apiEndpoint;

final HttpLink httpLink = HttpLink(
    // '$currentHost/graphql',
    "https://poimen.firstlovecenter.com/graphql");
final authToken = AuthService.instance.auth0AccessToken.toString();
FlutterSecureStorage secureStorage = const FlutterSecureStorage();
final AuthLink authLink = AuthLink(
  getToken: () async {
    String? token = await secureStorage.read(key: 'accessToken');
   
    return 'Bearer $token';
  },
);

final Link link = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.cacheAndNetwork),
      watchQuery: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      ),
    ),
    link: link,
  ),
);
