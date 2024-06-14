import 'package:graphql_flutter/graphql_flutter.dart';

final getBacentaIdls = gql('''
 query getBacentaIdls(\$id: ID!) {
    bacentas(where: { id: \$id }) {
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
        visitationArea
      }
    }
  }
''');
