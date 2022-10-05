import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipIdls = gql('''
 query getFellowshipIdls(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      idls {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
