import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipServices = gql('''
 query getFellowshipServices(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      services(limit: 10) {
        id
        typename
        attendance
        markedAttendance
        serviceDate {
            date
         } 
      }
    }
  }
  ''');

final getBacentaServices = gql('''
  query getBacentaServices(\$id: ID!) {
      bacentas(where: { id: \$id }) {
        id
        typename
        name
        bussing(limit: 10) {
          id
          typename
          attendance
          markedAttendance
          serviceDate {
            date
         } 
        }
      }
    }
    ''');
