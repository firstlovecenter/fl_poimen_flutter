import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyFellowshipAttendanceDefaultersList = gql('''
 query getConstituencyFellowshipAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
    id
    name
    typename
    fellowshipAttendanceDefaulters {
      id
      name
      typename
      leader {
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
}
''');
