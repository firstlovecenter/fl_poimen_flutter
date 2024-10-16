import 'package:graphql_flutter/graphql_flutter.dart';

final getCouncilAttendanceDefaultersByGovernorship = gql('''
   query getCouncilAttendanceDefaultersByGovernorship(\$id: ID!) {
     councils(where: { id: \$id }) {
       id
       name
       typename
       governorships (options: {sort: [{name: ASC}]}) {
          id
          name
          typename
          leader {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          admin {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          fellowshipServicesThisWeekCount
          fellowshipServiceAttendanceDefaultersCount
          fellowshipBussingLastWeekCount
          fellowshipBussingAttendanceDefaultersCount
       }
     }
   }
  ''');

final getStreamAttendanceDefaultersByCouncil = gql('''
   query getStreamAttendanceDefaultersByCouncil(\$id: ID!) {
     streams(where: { id: \$id }) {
       id
       name
       typename
       councils (options: {sort: [{name: ASC}]}) {
          id
          name
          typename
          leader {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          admin {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          fellowshipServicesThisWeekCount
          fellowshipServiceAttendanceDefaultersCount
          fellowshipBussingLastWeekCount
          fellowshipBussingAttendanceDefaultersCount
       }
     }
   }
  ''');

final getCampusAttendanceDefaultersByStream = gql('''
   query getCampusAttendanceDefaultersByStream(\$id: ID!) {
     campuses(where: { id: \$id }) {
       id
       name
       typename
       streams (options: {sort: [{name: ASC}]}) {
          id
          name
          typename
          leader {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          admin {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          fellowshipServicesThisWeekCount
          fellowshipServiceAttendanceDefaultersCount
          fellowshipBussingLastWeekCount
          fellowshipBussingAttendanceDefaultersCount
       }
     }
   }
  ''');
