import 'package:graphql_flutter/graphql_flutter.dart';

final getBacentaServices = gql('''
 query getBacentaServices(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      services(limit: 10) {
        id
        typename
        attendance
        markedAttendance(churchId: \$id)
        serviceDate {
            date
         } 
      }
    }
  }
  ''');

final getSundayBussing = gql('''
  query getSundayBussing(\$id: ID!) {
      bacentas(where: { id: \$id }) {
        id
        typename
        name
        bussing(limit: 10) {
          id
          typename
          attendance
          markedAttendance(churchId: \$id)
          serviceDate {
            date
         } 
        }
      }
    }
    ''');

final getHubServices = gql('''
 query getHubServices(\$id: ID!) {
    hubs(where: { id: \$id }) {
      id
      typename
      name
      services(limit: 10) {
        id
        typename
        attendance
        markedAttendance(churchId: \$id)
        serviceDate {
            date
         } 
      }
    }
  }
  ''');
