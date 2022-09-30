import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyAttendanceDefaulters = gql('''
   query getConstituencyAttendanceDefaulters(\$id: ID!) {
     constituencies(where: { id: \$id }) {
       id
       name
       typename
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');

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

final getConstituencyBacentaAttendanceDefaultersList = gql('''
 query getConstituencyBacentaAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
    id
    name
    typename
    bacentaAttendanceDefaulters {
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
