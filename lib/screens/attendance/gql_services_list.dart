import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipServices = gql('''
 query getFellowshipServices(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      services(limit: 20) {
        id
        typename
        attendance
        markedAttendance(fellowshipId: \$id)
        serviceDate {
            date
         } 
      }
    }
  }
  ''');

final getSundayBussing = gql('''
  query getSundayBussing(\$id: ID!) {
      fellowships(where: { id: \$id }) {
        id
        typename
        name
        bussing(limit: 20) {
          id
          typename
          attendance
          markedAttendance(fellowshipId: \$id)
          serviceDate {
            date
         } 
        }
      }
    }
    ''');
