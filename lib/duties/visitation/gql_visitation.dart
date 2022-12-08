import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipOutstandingVisitations = gql('''
 query getFellowshipOutstandingVisitations(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      outstandingVisitations {
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
