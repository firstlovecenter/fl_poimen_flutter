import 'package:graphql_flutter/graphql_flutter.dart';

final getCouncilAttendanceDefaultersByConstituency = gql('''
   query getCouncilAttendanceDefaultersByConstituency(\$id: ID!) {
     councils(where: { id: \$id }) {
       id
       name
       typename
       constituencies (options: {sort: [{name: ASC}]}) {
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

final getGatheringAttendanceDefaultersByStream = gql('''
   query getGatheringAttendanceDefaultersByStream(\$id: ID!) {
     gatheringServices(where: { id: \$id }) {
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
