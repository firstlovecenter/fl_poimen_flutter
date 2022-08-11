import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:graphql_flutter/graphql_flutter.dart';

final String host = kIsWeb
    ? 'localhost'
    : Platform.isAndroid
        ? '10.0.2.2'
        : 'localhost';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink('http://$host:4001/graphql'),
  ),
);
