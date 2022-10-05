import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipImcls = gql('''
 query getFellowshipIdls(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      imcls {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getBacentaImcls = gql('''
 query getBacentaImcls(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      imcls {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
