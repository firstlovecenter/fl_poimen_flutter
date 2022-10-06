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
          fellowshipServicesThisWeekCount
          fellowshipAttendanceDefaultersCount
          bacentaBussingThisWeekCount
          bacentaAttendanceDefaultersCount
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
          fellowshipServicesThisWeekCount
          fellowshipAttendanceDefaultersCount
          bacentaBussingThisWeekCount
          bacentaAttendanceDefaultersCount
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
          fellowshipServicesThisWeekCount
          fellowshipAttendanceDefaultersCount
          bacentaBussingThisWeekCount
          bacentaAttendanceDefaultersCount
       }
     }
   }
  ''');
